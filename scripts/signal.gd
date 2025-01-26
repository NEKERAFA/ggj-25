extends Area3D
class_name SpawnSignal


@export var player: Player = null


func _on_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		var mouse_event = event as InputEventMouseButton
		if mouse_event.button_index == MOUSE_BUTTON_LEFT and mouse_event.pressed:
			player._restart_state()
			disable_spawn()

func enable_spawn():
	$CollisionShape3D.disabled = false
	$anim_pr_senalReplayDespawn_v01.hide()
	$anim_pr_senalReplaySpawn_v01.show()
	$anim_pr_senalReplaySpawn_v01/AnimationPlayer.play('senalReplayAction')


func disable_spawn():
	$CollisionShape3D.disabled = true
	$anim_pr_senalReplaySpawn_v01.hide()
	$anim_pr_senalReplayDespawn_v01.show()
	$anim_pr_senalReplayDespawn_v01/AnimationPlayer.play('senalReplayAction')
