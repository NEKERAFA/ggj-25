extends Word


@export var anim_player: AnimationPlayer = null


func _on_snapped() -> void:
	anim_player.play('to_level_1')
