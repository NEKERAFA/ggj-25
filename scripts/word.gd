extends AnimatableBody3D


var _grabbed: bool = false


@export var mouse_area: Area3D = null


func _ready() -> void:
	if mouse_area != null:
		mouse_area.input_event.connect(_on_area3d_input_event)


func _on_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	# Add grab state
	if event is InputEventMouseButton:
		var mouse_event = event as InputEventMouseButton
		if mouse_event.button_index == MOUSE_BUTTON_LEFT and mouse_event.pressed:
			_grabbed = true
			mouse_area.monitoring = true
			$CollisionShape3D.disabled = true
			
			for child in mouse_area.get_children():
				if child is CollisionShape3D:
					(child as CollisionShape3D).disabled = false


func _on_area3d_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	pass
	# Reset grab state
	if event is InputEventMouseButton:
		var mouse_event = event as InputEventMouseButton
		if mouse_event.button_index == MOUSE_BUTTON_LEFT and not mouse_event.pressed:
			_grabbed = false
			mouse_area.monitoring = false
			$CollisionShape3D.disabled = false
			
			for child in mouse_area.get_children():
				if child is CollisionShape3D:
					(child as CollisionShape3D).disabled = false
	
	# Move grab state
	if event is InputEventMouseMotion:
		var mouse_event = event as InputEventMouseMotion
		if _grabbed:
			position = Vector3(event_position.x, event_position.y, 0)
