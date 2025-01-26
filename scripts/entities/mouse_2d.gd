extends Node2D


func _ready() -> void:
	$AnimatedSprite2D.play('idle')


func _process(delta: float) -> void:
	var delta_pos = $cursor.position
	if $AnimatedSprite2D.animation == 'grab':
		delta_pos = $grab.position
	
	position = get_viewport().get_mouse_position() - delta_pos


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		var mouse_event = event as InputEventMouseButton
		if mouse_event.button_index == MOUSE_BUTTON_LEFT:
			if mouse_event.pressed:
				$AnimatedSprite2D.play('click')
			else:
				$AnimatedSprite2D.play('idle')
