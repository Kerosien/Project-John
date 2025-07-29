extends Control

@onready var WaveManager := $"/root/Main/WaveManager"

func _ready() -> void:
	hide()

func _on_button_pressed() -> void:
	print("🔄 Respawn button pressed")
	get_tree().paused = false
	get_tree().reload_current_scene()
