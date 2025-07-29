extends CharacterBody2D

class_name ZombieEnemy

# Variables
var max_health := 3
var speed := 100.0

@onready var sprite: Sprite2D = $Sprite2D

var player: Node2D = null
var current_health := max_health
var flash_duration := 0.1
var flash_timer := 0.0

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	
func _physics_process(delta: float) -> void:
	if player and player.is_inside_tree():
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * speed
		move_and_slide()
		look_at(player.global_position)
		
	if flash_timer > 0:
		flash_timer -= delta
		if flash_timer <= 0:
			sprite.modulate = Color.WHITE
		
func take_damage(amount: int = 1) -> void:
	current_health -= amount
	sprite.modulate = Color.RED
	flash_timer = flash_duration
	if current_health <= 0:
		get_node("/root/Main/WaveManager").on_enemy_killed()
		queue_free()
		
	
	
func is_enemy() -> bool:
	return true
