extends Area3D
class_name MouseGrabArea3D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Sprite3D.visible = monitoring


func start_grab() -> void:
	monitoring = true
	$CollisionShape3D.disabled = false


func release_grab() -> void:
	monitoring = false
	$CollisionShape3D.disabled = true
