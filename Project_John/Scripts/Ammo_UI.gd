extends HBoxContainer

@onready var ammo_label = $"../AmmoCount"
@onready var reserve_label = $"../ReserveAmmo"
@onready var reload_prompt = $"../ReloadPrompt"


func _ready():
	await get_tree().process_frame
	update_ammo_ui(6, 6, 6, false)
	
	
func update_ammo_ui(current_ammo, max_ammo_in_clip, reserve_ammo, need_reload) -> void:
	ammo_label.text = str(current_ammo) + " / " + str(max_ammo_in_clip)
	reserve_label.text = " + " + str(reserve_ammo)
	
	if need_reload:
		reload_prompt.text = "Press R to reload!"
		
	else:
		reload_prompt.text = ""
	
