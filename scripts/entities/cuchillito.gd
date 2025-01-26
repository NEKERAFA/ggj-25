extends StaticBody3D


func _on_body_entered(body: Node3D) -> void:
	if body is Player:
		(body as Player).hurt()
