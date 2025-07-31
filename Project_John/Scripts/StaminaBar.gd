# StaminaBar.gd
extends HBoxContainer

@export var icon_scene: PackedScene
var max_stamina: int = 100
var total_orbs: int = 0

const ORB_VALUE := 10

func _ready() -> void:
	total_orbs = max_stamina / ORB_VALUE
	
	for i in range(total_orbs):
		var orb = icon_scene.instantiate()
		orb.visible = true
		add_child(orb)
		
	set_stamina(max_stamina)
	var player = get_tree().get_first_node_in_group("player")
	
	if player:
		player.stamina_changed.connect(Callable(self, "set_stamina"))
		
func set_stamina(current_stamina: int) -> void:
	var orb_count = clamp(int(current_stamina / ORB_VALUE), 0, total_orbs)
	
	for i in range(total_orbs):
		get_child(i).visible = i < orb_count
