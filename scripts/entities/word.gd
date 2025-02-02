extends AnimatableBody3D
class_name Word


signal snapped


const GRABBED_WAIT = 0.2
const MIN_SNAP = 5.0



var _grabbed: bool = false
var _grabbed_origin: Vector3 = Vector3.ZERO
#var _gabbed_time: float = 0.0
#var _moved: bool = false
#var _snapping: bool = false
#var _hovered: bool = false
#
#
@export var mouse_area: MouseGrabArea3D = null
@export var snap_points: Node = null
#@export var rotable: bool = true
#@export var min_snap: float = 0.0
#
#
#func _process(delta: float) -> void:
	#if _grabbed and not _moved:
		#_gabbed_time += delta
#
		#if _gabbed_time >= GRABBED_WAIT and rotable:
			## Rotate and reset
			#rotate_z(deg_to_rad(90))
			#_reset_grab()
#
#
#func _physics_process(delta: float) -> void:
	#if _grabbed:
		#if global_position.y < min_snap and not _snapping:
			#start_snap()
		#elif global_position.y >= min_snap and _snapping:
			#release_snap()
#
#
#func _on_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	## Add grab state
	#if event is InputEventMouseButton:
		#var mouse_event = event as InputEventMouseButton
		#if mouse_event.button_index == MOUSE_BUTTON_LEFT and mouse_event.pressed:
			#_start_grab()
#
#
#func _on_area3d_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	##if event_position.distance_to(global_position) < 1:
		#if event is InputEventMouseButton:
			#var mouse_event = event as InputEventMouseButton
			#if mouse_event.button_index == MOUSE_BUTTON_LEFT and not mouse_event.pressed:
				#if _grabbed:
					## Rotate
					#if not _moved and rotable:
						#rotate_z(deg_to_rad(90))
					#
					## Reset grab state
					#_reset_grab()
					#
					#if _snapping and snap_points:
						#_snap_to_nearest()
		#
		## Move grab state
		#if event is InputEventMouseMotion:
			#var mouse_event = event as InputEventMouseMotion
			#if _grabbed and (_moved or global_position.distance_to(event_position) > 0.1):
				## Update position
				#global_position = Vector3(event_position.x, event_position.y, 0)
				#if not _moved:
					#_moved = true
#
#
#func _start_grab():
	#_grabbed = true
	#_gabbed_time = 0.0
	#_moved = false
	#$CollisionShape3D.disabled = true
	#mouse_area.start_grab()
#
#
#func _reset_grab():
	#_grabbed = false
	#_gabbed_time = 0.0
	#_moved = false
	#$CollisionShape3D.disabled = false
	#mouse_area.release_grab()
#
#
#func _snap_to_nearest():
	#var nearest = null
	#for point: Node3D in snap_points.get_children():
		#if (
			#not nearest 
			#or global_position.distance_to(point.global_position) < global_position.distance_to(nearest)
		#):
			#nearest = point.global_position
	#
	#if nearest:
		#global_position = nearest
		#snapped.emit()
#
#
#func start_snap():
	#_snapping = true
	#mouse_area._snap_area = true
#
#
#func release_snap():
	#_snapping = false
	#mouse_area._snap_area = false
#
#
#func _on_mouse_entered() -> void:
	#pass
#
#
#func _on_mouse_exited() -> void:
	#pass

func _ready() -> void:
	# Connect signals
	GameManager.word_started_grab.connect(_on_word_started_grab)
	GameManager.word_released_grab.connect(_on_word_released_grab)


func _on_input_event(_c: Node, event: InputEvent, event_position: Vector3, _n: Vector3, _s: int) -> void:
	if Utils.is_click_pressed(event):
		_start_grab()
		_grabbed_origin = event_position - global_position


func _on_area_input_event(_c: Node, event: InputEvent, event_position: Vector3, _n: Vector3, _s: int) -> void:
	if Utils.is_click_released(event):
		_release_grab()
		
		if snap_points:
			_check_nearest_point()
	
	if Utils.is_mouse_moved(event):
		global_position = Vector3(event_position.x - _grabbed_origin.x, event_position.y - _grabbed_origin.y, global_position.z)


func _start_grab() -> void:
	#print("start grab")
	GameManager.word_started_grab.emit()
	_grabbed = true
	
	if mouse_area:
		mouse_area.start_grab()
		mouse_area.input_event.connect(_on_area_input_event)


func _release_grab() -> void:
	#print("release grab")
	GameManager.word_released_grab.emit()
	_grabbed = false
	
	if mouse_area:
		mouse_area.release_grab()
		mouse_area.input_event.disconnect(_on_area_input_event)


func _check_nearest_point() -> void:
	var nearest = null
	for point: Node3D in snap_points.get_children():
		if (
			(not nearest 
			or global_position.distance_to(point.global_position) < global_position.distance_to(nearest))
			and (global_position.distance_to(point.global_position) < MIN_SNAP)
		):
			nearest = point.global_position
	
	if nearest:
		global_position = nearest
		snapped.emit()


func _on_word_started_grab() -> void:
	$CollisionShape3D.disabled = true


func _on_word_released_grab() -> void:
	$CollisionShape3D.disabled = false


func _on_mouse_entered() -> void:
	GameManager.word_hovered.emit()


func _on_mouse_exited() -> void:
	GameManager.word_unhovered.emit()
