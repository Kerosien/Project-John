extends CharacterBody2D

class_name ShootingEnemy

var max_health := 3
var speed := 100.0
@export var bullet_scene: PackedScene
var shoot_cooldown := 1.0         # Seconds between shots
var min_distance := 200.0         # Stay at least this far away
var max_shoot_distance := 500.0   # only shoot within this distance
var player: Node2D = null
var current_health := max_health
var flash_duration := 0.1
var flash_timer := 0.0
var shoot_timer := 0.0

@onready var sprite: Sprite2D = $Sprite2D

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	
func _physics_process(delta: float) -> void:
	if not player or not player.is_inside_tree():
		return
		
	var to_player = player.global_position - global_position
	var dist = to_player.length()
	var dir = to_player.normalized()
	var can_see = _has_line_of_sight(to_player)
		
	if can_see and dist <= max_shoot_distance:
		if dist < min_distance:
			velocity = -dir * speed
		elif dist > min_distance:
			velocity = dir * speed
		else:
			velocity = Vector2.ZERO
			
		shoot_timer -= delta
		if shoot_timer <= 0:
			_shoot(dir)
			shoot_timer = shoot_cooldown
			
	else:
		velocity = dir * speed
	
	move_and_slide()
	if velocity != Vector2.ZERO:
		look_at(player.global_position)
		
	if flash_timer > 0:
		flash_timer -= delta
		if flash_timer <= 0:
			sprite.modulate = Color.WHITE
			
func _has_line_of_sight(_to_player: Vector2) -> bool:
	var space = get_world_2d().direct_space_state
	var q = PhysicsRayQueryParameters2D.create(global_position, player.global_position)
	q.exclude = [self]
	var result = space.intersect_ray(q)
	return result.is_empty() or result.collider == player

func _shoot(_dir: Vector2) -> void:
	var bullet = bullet_scene.instantiate()
	bullet.global_transform = $Muzzle.global_transform
	get_tree().current_scene.add_child(bullet)

func take_damage(amount: int = 1) -> void:
	current_health -= amount
	sprite.modulate = Color.RED
	flash_timer = flash_duration
	if current_health <= 0:
		get_node("/root/Main/WaveManager").on_enemy_killed()
		queue_free()
		
func is_enemy() -> bool:
	return true
