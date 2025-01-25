extends Area3D


func _on_body_entered(body: Node3D) -> void:
	if body is Word:
		(body as Word).start_snap()


func _on_body_exited(body: Node3D) -> void:
	if body is Word:
		(body as Word).release_snap()
