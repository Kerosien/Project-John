extends Node2D

@export var spawner_path: NodePath
@export var enemy_scene: PackedScene

@export var enemies_per_wave: int = 0
@export var time_between_waves: float = 5 # in seconds
var current_wave: int = 0
var enemies_spawned: int = 0
var enemies_alive: int = 0
var wave: int = 1

@onready var wave_timer := $WaveTimer
@onready var spawner = get_node(spawner_path)

enum EndCondition {TIME, KILL}
var current_end_condition : EndCondition

func _ready():
	wave_timer.wait_time = time_between_waves
	wave = 1
	start_next_wave()

func start_next_wave():
	current_wave += 1
	
	# Choose random contition
	if randi() % 2 == 0:
		current_end_condition = EndCondition.TIME
		print("▶ Wave %d is TIME-based" % current_wave)
		
	else:
		current_end_condition = EndCondition.KILL
		print("▶ Wave %d is KILL-based" % current_wave)
		
	# How many spawn
	var count = enemies_per_wave + (current_wave + 1) * 2
	enemies_spawned = count

	# only set enemies_alive if its a kill wave
	if current_end_condition == EndCondition.KILL:
		enemies_alive = count
	else:
		enemies_alive = 0
		
	# spawn all 
	spawn_enemies(count)
	
	spawner.spawning_enabled = (current_end_condition == EndCondition.TIME)
	
	# only start if on TIME wave
	if current_end_condition == EndCondition.TIME:
		spawner.timer.start()
		spawner.spawning_enabled = true
		wave_timer.start()
		
	
		
func spawn_enemies(count: int) -> void:
	for i in range(count):
		spawner.spawn_enemy()
		enemies_spawned += 1
		print("▶ Wave ", current_wave, " spawned enemy #", i + 1, " of ", count)

func on_enemy_killed():
	if current_end_condition != EndCondition.KILL:
		return
		
	enemies_alive -= 1
	print("--Enemy died; %d left" % enemies_alive)
	
	if enemies_alive <= 0:
		start_next_wave()

func _on_wave_timer_timeout() -> void:
	if current_end_condition == EndCondition.TIME:
		# stop any further auto‐spawns once you transition
		spawner.timer.stop()
		spawner.spawning_enabled = false
		print("Timer UP; advancing wave")
		start_next_wave()
	
