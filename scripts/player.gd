extends CharacterBody3D


const SPEED := 4.0
const JUMP_VELOCITY := 4.5


@export var start_movement: bool = false

@onready var _coyote_timer = $CoyoteTimer

var _mouse_entering: bool = false
var _jumping: bool = false
var _is_coyote: bool = false
var _is_coyote_finished: bool = true


func _input(event: InputEvent) -> void:
	# Handle jump.
	if event is InputEventMouseButton:
		var mouse_event = event as InputEventMouseButton
		if (
			mouse_event.button_index == MOUSE_BUTTON_LEFT and mouse_event.pressed
			and not _mouse_entering and velocity.x > 0 # x > 0? player is moving
			and not _jumping
		):
			_jumping = true


func _physics_process(delta: float) -> void:
	# Make jump
	if _jumping and velocity.y == 0 and (is_on_floor() or (_coyote_timer and not _is_coyote_finished)):
		velocity.y = JUMP_VELOCITY
	
	if not is_on_floor():
		# Add coyote time
		if not _jumping and not _is_coyote:
			_is_coyote = true
			_is_coyote_finished = false
			$CoyoteTimer.start()
		
		# Add the gravity.
		elif _jumping or (_is_coyote and _is_coyote_finished):
			velocity += get_gravity() * delta
	else:
		# Reset jump
		if _jumping:
			_jumping = false
		
		# Reset coyote time
		if _is_coyote:
			_is_coyote = false
			_is_coyote_finished = true
			$CoyoteTimer.stop()

	move_and_slide()


func _on_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	# Move player to left
	if event is InputEventMouseButton:
		var mouse_event = event as InputEventMouseButton
		# Start movement
		if mouse_event.button_index == MOUSE_BUTTON_LEFT and mouse_event.pressed:
			velocity.x = SPEED


func _on_mouse_exited() -> void:
	_mouse_entering = false


func _on_mouse_entered() -> void:
	_mouse_entering = true


func _on_coyote_timeout() -> void:
	_is_coyote_finished = true
