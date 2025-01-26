extends Node


func can_player_walk() -> bool:
	return false


func _notification(what: int) -> void:
	match what:
		NOTIFICATION_WM_MOUSE_ENTER:
			Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
		NOTIFICATION_WM_MOUSE_EXIT:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
