extends Node


signal word_hovered
signal word_unhovered
signal word_started_grab
signal word_released_grab



func _notification(what: int) -> void:
	match what:
		NOTIFICATION_WM_MOUSE_ENTER:
			Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
		NOTIFICATION_WM_MOUSE_EXIT:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
