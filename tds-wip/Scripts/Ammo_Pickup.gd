extends Area2D

var ammo_amount: int = 6


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.reserve_ammo += ammo_amount
		body.update_ammo_ui()
		queue_free()
