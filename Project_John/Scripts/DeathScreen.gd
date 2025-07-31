extends Control

@onready var WaveManager := $"/root/Main/WaveManager"

func _ready() -> void:
	hide()
	
	# --- Death screen background color --- #
	set_anchors_preset(Control.PRESET_FULL_RECT)
	set_offsets_preset(Control.PRESET_FULL_RECT)
	$ColorRect.set_anchors_preset(Control.PRESET_FULL_RECT)
	$ColorRect.set_offsets_preset(Control.PRESET_FULL_RECT)

func _on_button_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
