extends Node2D


var _hovered: bool = false
var _grabbed: bool = false


func _ready() -> void:
	# Connect signals
	GameManager.word_hovered.connect(_on_word_hovered)
	GameManager.word_unhovered.connect(_on_word_unhovered)
	GameManager.word_started_grab.connect(_on_word_started_grab)
	GameManager.word_released_grab.connect(_on_word_released_grab)
	
	# Start play animation
	$AnimatedSprite2D.play('idle')


func _process(delta: float) -> void:
	# Get delta position
	var delta_pos = $cursor.position
	if _grabbed:
		delta_pos = $grab.position
	
	position = get_viewport().get_mouse_position() - delta_pos


func _input(event: InputEvent) -> void:
	if Utils.is_click_pressed(event) and not _grabbed and not _hovered:
		$AnimatedSprite2D.play('click')


func _on_word_hovered() -> void:
	_hovered = true
	if not _grabbed:
		$AnimatedSprite2D.play("hover")


func _on_word_unhovered() -> void:
	_hovered = false
	if not _grabbed:
		$AnimatedSprite2D.play_backwards("hover")


func _on_word_started_grab() -> void:
	_grabbed = true
	$AnimatedSprite2D.play("grab")


func _on_word_released_grab() -> void:
	_grabbed = false
	$AnimatedSprite2D.play_backwards("grab")


func _on_animation_finished() -> void:
	if not _grabbed and not _hovered:
		$AnimatedSprite2D.play("idle")
