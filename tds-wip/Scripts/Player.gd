extends CharacterBody2D

# --- Variables ---
var walk_speed := 200.0
var sprint_speed := 350.0
var sprint_duration := 1.5  
var sprint_cooldown := 3.0  
var max_health := 1
var invincibility_time := 1.0

var is_sprinting := false
var can_sprint := true
var sprint_timer := 0.0
var cooldown_timer := 0.0
var invincibility_timer := 0.0
var current_health := max_health
var flash_duration := 0.1
var flash_timer := 0.0
var max_ammo_in_clip := 6
var current_ammo := max_ammo_in_clip
var reserve_ammo := 6
var reload_time := 0.25
var is_reloading := false

@onready var camrea = $Camera2D
@onready var sprite: Sprite2D = $Sprite2D
@onready var health_bar := $"../UI/HealthBar"
@onready var ammo_ui = $"../UI/AmmoUI"
@onready var reload_text = $"../UI/ReloadPrompt"
@onready var death_screen = $"../UI/DeathScreen"

const bulletScene = preload("res://Scenes/Bullet.tscn")

func _ready() -> void:
	
	# Camera bounds
	camrea.make_current()
	set_camera_limits()
	
	health_bar.set_health(current_health)
	await get_tree().process_frame
	update_ammo_ui()


func _physics_process(delta: float) -> void:
	
	look_at(get_global_mouse_position())
	
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if Input.is_action_just_pressed("sprint") and can_sprint:
		is_sprinting = true
		sprint_timer = sprint_duration
		can_sprint = false

	if is_sprinting:
		sprint_timer -= delta
		if sprint_timer <= 0:
			is_sprinting = false
			cooldown_timer = sprint_cooldown

	if not can_sprint and not is_sprinting:
		cooldown_timer -= delta
		if cooldown_timer <= 0:
			can_sprint = true

	var speed = sprint_speed if is_sprinting else walk_speed
	velocity = direction * speed
	move_and_slide()

	if Input.is_action_just_pressed("fire"):
		shoot()
	
	if invincibility_timer > 0:
		invincibility_timer -= delta
		
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		if collider and collider.has_method("is_enemy") and invincibility_timer <= 0:
			take_damage()
			break
		
	if flash_timer > 0:
		flash_timer -= delta
		if flash_timer <= 0:
			sprite.modulate = Color.WHITE

func shoot():
	
	if is_reloading or current_ammo <= 0:
		return
	
	var bullet = bulletScene.instantiate()
	bullet.global_transform = $Muzzle.global_transform
	get_tree().root.add_child(bullet)
	current_ammo -= 1
	update_ammo_ui()
	
func take_damage(amount: int = 1) -> void:
	
	if invincibility_timer > 0:
		return
		
	current_health -= amount
	invincibility_timer = invincibility_time
	health_bar.set_health(current_health)
	
	sprite.modulate = Color.RED
	flash_timer = flash_duration
		
	if current_health <= 0:
		die()
			
func die() -> void:
	get_tree().paused = true
	sprite.visible = false
	
func set_camera_limits():
	
	var tilemap := get_parent().get_node("Level")
	var tile_size = tilemap.tile_set.tile_size
	var used_rect = tilemap.get_used_rect()
	
	var map_position = tilemap.to_global(used_rect.position * tile_size)
	var map_size = used_rect.size * tile_size
	
	camrea.limit_left = int (map_position.x)
	camrea.limit_top = int (map_position.y)
	camrea.limit_right = int (map_position.x + map_size.x)
	camrea.limit_bottom = int (map_position.y + map_size.y)
	
func _process(_delta):
	# Reload check
	if Input.is_action_just_pressed("reload"):
		reload_text.modulate = Color.RED
		reload()
		
func reload():
	if is_reloading or current_ammo == max_ammo_in_clip or reserve_ammo <= 0:
		return
	is_reloading = true
	$ReloadTimer.start(reload_time)
	
		
	
func _on_reload_timer_timeout() -> void:
	var needed = max_ammo_in_clip - current_ammo
	var available = min(needed, reserve_ammo)
	current_ammo += available
	reserve_ammo -= available
	is_reloading = false
	reload_text.modulate = Color.WHITE
	update_ammo_ui()
	
func update_ammo_ui():
	var need_reload = current_ammo <= 0 and reserve_ammo <= 0
	ammo_ui.update_ammo_ui(current_ammo, max_ammo_in_clip, reserve_ammo, need_reload)
