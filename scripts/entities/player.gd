extends CharacterBody3D
class_name Player


const SPEED := 2.0
const JUMP_VELOCITY := 2.5


@export var start_movement: bool = false


@onready var _coyote_timer = $CoyoteTimer
@onready var _model: GeroController = $Gero


var _mouse_entering: bool = false
var _jumping: bool = false
var _is_coyote: bool = false
var _is_coyote_finished: bool = true
var _initial_position: Vector3


func _ready() -> void:
	#_model.current_anim = GeroController.GeroAnimation.IDLE
	_initial_position = position


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
		_model.current_anim = GeroController.GeroAnimation.JUMP
	
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
	
	if position.y < -6:
		_restart_state()


func _on_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	# Move player to left
	if event is InputEventMouseButton:
		var mouse_event = event as InputEventMouseButton
		# Start movement
		if mouse_event.button_index == MOUSE_BUTTON_LEFT and mouse_event.pressed:
			velocity.x = SPEED
			_model.current_anim = GeroController.GeroAnimation.WALK


func _on_mouse_exited() -> void:
	_mouse_entering = false


func _on_mouse_entered() -> void:
	_mouse_entering = true


func _on_coyote_timeout() -> void:
	_is_coyote_finished = true


func hurt():
	velocity.x = 0
	velocity.y = JUMP_VELOCITY
	_model.current_anim = GeroController.GeroAnimation.JUMP
	collision_layer = 0
	collision_mask = 0
	_mouse_entering = false
	_jumping = false
	_is_coyote = false
	_is_coyote_finished = true
	$RestartTimer.start()


func _on_restart_timeout() -> void:
	_restart_state()


func _restart_state() -> void:
	velocity.y = 0
	_model.current_anim = GeroController.GeroAnimation.IDLE
	collision_layer = 1
	collision_mask = 1
	position = _initial_position
