extends Area3D
class_name MouseGrabArea3D


var _snap_area: bool = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#$Sprite3D.visible = monitoring
	#$Sprite3D.modulate = Color(1, 0, 0, 0.25) if _snap_area else Color(0, 1, 1, 0.25)
	pass


func start_grab() -> void:
	monitoring = true
	$CollisionShape3D.disabled = false


func release_grab() -> void:
	monitoring = false
	$CollisionShape3D.disabled = true
