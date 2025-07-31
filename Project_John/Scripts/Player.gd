extends CharacterBody2D

#----- Signals -----#
signal stamina_changed(new_stamina: int)

# --- Health --- #
var max_health := 10
var current_health := max_health

# --- Invinciblity/Flash timers --- #
var invinc_time := 0.25
var invinc_timer := 0.0
var flash_duration := 0.1
var flash_timer := 0.0

# --- Stamina --- #
var max_stamina := 100.0 # counted in seconds 
var stamina_drain_per_sec := 25.0 # How fast to drain stamina
var stamina_regen_per_sec := 100.0 # How fast to regen
var stamina_regen_delay := 1.0 # Time before regen

var stamina := max_stamina
var prev_stamina := max_stamina
var stamina_regen_timer := 0.0 # Gets set to regen delay
var is_sprinting := false

# --- Speed --- #
var walk_speed := 100.0
var sprint_speed := 300.0

# ---Ammo/Reloading system--- #
var max_ammo_in_clip := 6
var current_ammo := max_ammo_in_clip
var reserve_ammo := 6
var reload_time := 0.25
var is_reloading := false

# --- @Onready --- #
@onready var camera = $Camera2D
@onready var sprite: Sprite2D = $Sprite2D
@onready var health_bar := $"../UI/HealthBar"
@onready var ammo_ui = $"../UI/AmmoUI"
@onready var reload_text = $"../UI/AmmoUI/ReloadPrompt"
@onready var death_screen: Control = $"../UI/DeathScreen"
@onready var stamina_bar := $"../UI/StaminaBar"

# --- Const --- #
const bulletScene = preload("res://Scenes/Ammo/Bullet.tscn")


# ---------- FUNCTIONS ---------- #
func _ready() -> void:
	camera.make_current()
	stamina_bar.set_stamina(max_stamina)
	await get_tree().process_frame
	update_ammo_ui()
	
func _physics_process(delta: float) -> void:
	look_at(get_global_mouse_position())
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	prev_stamina = stamina
	health_bar.set_health(current_health)
	
	# sprint drain vs. regen
	if Input.is_action_pressed("sprint") and stamina > 0:
		is_sprinting = true
		stamina -= stamina_drain_per_sec * delta
		stamina_regen_timer = stamina_regen_delay
	else:
		is_sprinting = false
		if stamina_regen_timer > 0:
			stamina_regen_timer -= delta
		else:
			stamina += stamina_regen_per_sec * delta
	
	stamina = clamp(stamina, 0, max_stamina)
	
	if int(stamina) != int(prev_stamina):
		emit_signal("stamina_changed", int(stamina))
	
	if stamina <= 0:
		is_sprinting = false
	
	# movement
	var speed = sprint_speed if is_sprinting else walk_speed
	velocity = direction * speed
	move_and_slide()
	
	#-----SHOOTING LOGIC-----#
	if Input.is_action_just_pressed("fire"):
		shoot()
	
	if invinc_timer > 0:
		invinc_timer -= delta
		
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		if collider and collider.has_method("is_enemy") and invinc_timer <= 0:
			take_damage()
			break
		
	if flash_timer > 0:
		flash_timer -= delta
		if flash_timer <= 0:
			sprite.modulate = Color.WHITE
			
func _process(_delta):
	if Input.is_action_just_pressed("reload"):
		reload_text.modulate = Color.RED
		reload()
		
func update_ammo_ui():
	var need_reload = current_ammo <= 0 and reserve_ammo <= 0
	ammo_ui.update_ammo_ui(current_ammo, max_ammo_in_clip, reserve_ammo, need_reload)
	
func shoot():
	if is_reloading or current_ammo <= 0:
		return
		
	var bullet = bulletScene.instantiate()
	bullet.global_transform = $Muzzle.global_transform
	get_tree().root.add_child(bullet)
	current_ammo -= 1
	update_ammo_ui()
	
func reload():
	if is_reloading or current_ammo == max_ammo_in_clip or reserve_ammo <= 0:
		return
	is_reloading = true
	$ReloadTimer.start(reload_time)
	
#-----DAMAGE RECIEVED-----#
func take_damage(amount: int = 1) -> void:
	if invinc_timer > 0:
		return

	current_health -= amount
	invinc_timer = invinc_time
	health_bar.set_health(current_health)
	sprite.modulate = Color.RED
	flash_timer = flash_duration
	
	if current_health <= 0:
		die()
		
#-----DEATH-----#
func die() -> void:
	get_tree().paused = true
	sprite.visible = false
	death_screen.show()
	
func _on_reload_timer_timeout() -> void:
	var needed = max_ammo_in_clip - current_ammo
	var available = min(needed, reserve_ammo)
	current_ammo += available
	reserve_ammo -= available
	is_reloading = false
	reload_text.modulate = Color.WHITE
	update_ammo_ui()
