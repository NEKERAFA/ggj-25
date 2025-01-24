extends CharacterBody3D


const SPEED := 5.0
const JUMP_VELOCITY := 4.5


@export var start_movement: bool = false

var _mouse_entered: bool = false


func _input(event):
	# Handle jump.
	if (
			not _mouse_entered
			and velocity.x > 0
			and is_on_floor()
			and (event is InputEventMouseButton)
	):
		var mouse_event = event as InputEventMouseButton
		if mouse_event.button_index == MOUSE_BUTTON_LEFT and mouse_event.pressed:
			velocity.y = JUMP_VELOCITY


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	move_and_slide()


func _on_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	# Move player to left
	if event is InputEventMouseButton:
		var mouse_event = event as InputEventMouseButton
		if mouse_event.button_index == MOUSE_BUTTON_LEFT and mouse_event.pressed:
			velocity.x = SPEED


func _on_mouse_exited():
	_mouse_entered = false


func _on_mouse_entered():
	_mouse_entered = true
