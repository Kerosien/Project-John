extends HBoxContainer

@export var icon_scene: PackedScene

func set_health(current_health: int) -> void:
	# Clear all children
	for child in get_children():
		child.queue_free()
		
	# Re-add current health icons
	for i in current_health:
		var icon = icon_scene.instantiate()
		add_child(icon)
