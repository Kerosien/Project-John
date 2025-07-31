extends Node2D

@export var spawn_area_path: NodePath
@export var enemy_scene: PackedScene
@export var ammo_scene: PackedScene
@export var health_scene: PackedScene

var attempts := 10
var spawning_enabled: bool = false

@onready var spawn_area: CollisionPolygon2D = get_node(spawn_area_path)
@onready var timer := $Timer
@onready var ammo_timer := $AmmoSpawnTimer
@onready var health_timer := $HealthSpawnTimer

func _ready():
	# Sets how fast ammo spawns
	ammo_timer.wait_time = 1.0
	ammo_timer.autostart = true
	ammo_timer.start()
	
	# Sets how fast health spawns
	health_timer.wait_time = 1.0
	health_timer.autostart = true
	health_timer.start()

func _on_timer_timeout() -> void:
	if not spawning_enabled or not enemy_scene:
		return

	for i in range(attempts):
		var pos = get_random_point_in_spawn_area()
		
		if pos != Vector2.ZERO and not get_viewport().get_visible_rect().has_point(pos):
			print("Spawner timed-spawn enemy at ", pos)
			var enemy = enemy_scene.instantiate()
			enemy.global_position = pos
			get_tree().current_scene.call_deferred("add_child", enemy)
			break
			
func spawn_health():
	var point = get_random_point_in_spawn_area()
	if point == Vector2.ZERO:
		return
		
	var health = health_scene.instantiate()
	health.global_position = point
	get_tree().current_scene.add_child(health)

func spawn_ammo():
	var point = get_random_point_in_spawn_area()
	if point == Vector2.ZERO:
		return
		
	var ammo = ammo_scene.instantiate()
	ammo.global_position = point
	get_tree().current_scene.add_child(ammo)

func spawn_enemy():
	var pos = get_random_point_in_spawn_area()
	if pos == Vector2.ZERO:
		return
		
	var enemy = enemy_scene.instantiate()
	enemy.global_position = pos
	get_tree().current_scene.call_deferred("add_child", enemy)
	
func get_random_point_in_spawn_area() -> Vector2:
	if not spawn_area or spawn_area.polygon.is_empty():
		return Vector2.ZERO

	var polygon := spawn_area.polygon
	var min_x := polygon[0].x
	var max_x := polygon[0].x
	var min_y := polygon[0].y
	var max_y := polygon[0].y

	for point in polygon:
		min_x = min(min_x, point.x)
		max_x = max(max_x, point.x)
		min_y = min(min_y, point.y)
		max_y = max(max_y, point.y)

	for _i in 10:
		var local_point = Vector2(randf_range(min_x, max_x), randf_range(min_y, max_y))

		if Geometry2D.is_point_in_polygon(local_point, polygon):
			return spawn_area.to_global(local_point)

	return Vector2.ZERO
	
func _on_ammo_spawn_timer_timeout() -> void:
	spawn_ammo()


func _on_health_spawn_timer_timeout() -> void:
	spawn_health()
