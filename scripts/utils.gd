extends Object
class_name Utils


static func is_click_pressed(event: InputEvent) -> bool:
	return (
		(event is InputEventMouseButton and (event as InputEventMouseButton).button_index == MOUSE_BUTTON_LEFT and (event as InputEventMouseButton).pressed)
		or (event is InputEventScreenTouch and (event as InputEventScreenTouch).pressed)
	)


static func is_click_released(event: InputEvent) -> bool:
	return (
		(event is InputEventMouseButton and (event as InputEventMouseButton).button_index == MOUSE_BUTTON_LEFT and not (event as InputEventMouseButton).pressed)
		or (event is InputEventScreenTouch and not (event as InputEventScreenTouch).pressed)
	)

static func is_mouse_moved(event: InputEvent) -> bool:
	return (event is InputEventMouseMotion) or (event is InputEventScreenDrag)
