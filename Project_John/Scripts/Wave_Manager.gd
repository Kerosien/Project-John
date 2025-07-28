extends Node2D

@export var spawner_path: NodePath
@export var enemy_scene: PackedScene

var enemies_per_wave: int = 5
var time_between_waves: float = 10.0
var current_wave: int = 0
var enemies_spawned: int = 0
var enemies_alive: int = 0
var wave_timer: Timer

@onready var spawner = get_node(spawner_path)

func _ready():
	wave_timer = Timer.new()
	wave_timer.wait_time = time_between_waves
	wave_timer.one_shot = true
	wave_timer.timeout.connect(_on_wave_timer_timeout)
	add_child(wave_timer)

	start_next_wave()

func start_next_wave():
	current_wave += 1
	enemies_spawned = 0
	enemies_alive = enemies_per_wave + current_wave * 2  # Increase enemies each wave
	spawn_enemies(enemies_alive)
	wave_timer.start()

func spawn_enemies(count: int):
	for i in count:
		spawner.spawn_enemy(enemy_scene)
		enemies_spawned += 1

func on_enemy_killed():
	enemies_alive -= 1
	if enemies_alive <= 0 and not wave_timer.is_stopped():
		wave_timer.stop()
		start_next_wave()

func _on_wave_timer_timeout():
	# If enemies are still alive, start the next wave anyway
	start_next_wave()
	
