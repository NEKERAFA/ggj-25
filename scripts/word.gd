extends AnimatableBody3D
class_name Word


const GRABBED_WAIT = 0.2
const MIN_SNAP = -1


var _grabbed: bool = false
var _gabbed_time: float = 0.0
var _moved: bool = false
var _snapping: bool = false


@export var mouse_area: MouseGrabArea3D = null
@export var snap_points: Node = null


func _ready() -> void:
	if mouse_area != null:
		mouse_area.input_event.connect(_on_area3d_input_event)


func _process(delta: float) -> void:
	if _grabbed and not _moved:
		_gabbed_time += delta

		if _gabbed_time >= GRABBED_WAIT:
			# Rotate and reset
			rotate_z(deg_to_rad(90))
			_reset_grab()


func _physics_process(delta: float) -> void:
	if _grabbed:
		if global_position.y < MIN_SNAP and not _snapping:
			start_snap()
		elif global_position.y >= MIN_SNAP and _snapping:
			release_snap()


func _on_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	# Add grab state
	if event is InputEventMouseButton:
		var mouse_event = event as InputEventMouseButton
		if mouse_event.button_index == MOUSE_BUTTON_LEFT and mouse_event.pressed:
			_start_grab()


func _on_area3d_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		var mouse_event = event as InputEventMouseButton
		if mouse_event.button_index == MOUSE_BUTTON_LEFT and not mouse_event.pressed:
			# Rotate
			if not _moved:
				rotate_z(deg_to_rad(90))
			
			# Reset grab state
			_reset_grab()
			
			if _snapping:
				_snap_to_nearest()
	
	# Move grab state
	if event is InputEventMouseMotion:
		var mouse_event = event as InputEventMouseMotion
		if _grabbed and (_moved or global_position.distance_to(event_position) > 0.1):
			# Update position
			position = Vector3(event_position.x, event_position.y, 0)
			if not _moved:
				_moved = true


func _start_grab():
	_grabbed = true
	_gabbed_time = 0.0
	_moved = false
	$CollisionShape3D.disabled = true
	mouse_area.start_grab()


func _reset_grab():
	_grabbed = false
	_gabbed_time = 0.0
	_moved = false
	$CollisionShape3D.disabled = false
	mouse_area.release_grab()


func _snap_to_nearest():
	var nearest = null
	for point: Node3D in snap_points.get_children():
		if (
			not nearest 
			or position.distance_to(point.position) < position.distance_to(nearest)
		):
			nearest = point.position
	
	if nearest:
		position = nearest


func start_snap():
	_snapping = true
	mouse_area._snap_area = true


func release_snap():
	_snapping = false
	mouse_area._snap_area = false
