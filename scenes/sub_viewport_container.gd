extends SubViewportContainer


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		$SubViewport.push_input(event, true)
