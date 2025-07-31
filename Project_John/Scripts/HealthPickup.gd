extends Area2D

var health_amount: int = 2

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.current_health += health_amount
		queue_free()
