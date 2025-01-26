extends Node3D
class_name GeroController


enum GeroAnimation { IDLE, WALK, JUMP, FALLING }


var current_anim:
	get:
		return current_anim
	
	set(value):
		current_anim = value
		
		match value:
			GeroAnimation.IDLE:
				$Falling.hide()
				$Idle.show()
				$Idle/AnimationPlayer.play('rig_x_geroAction')
				$Jump.hide()
				$Walk.hide()
			
			GeroAnimation.WALK:
				$Falling.hide()
				$Idle.hide()
				$Jump.hide()
				$Walk.show()
				$Walk/AnimationPlayer.play('rig_x_geroAction_001')
			
			GeroAnimation.JUMP:
				$Falling.hide()
				$Idle.hide()
				$Jump.show()
				$Jump/AnimationPlayer.play('rig_x_geroAction_001')
				$Walk.hide()
			
			GeroAnimation.FALLING:
				$Falling.show()
				$Falling/AnimationPlayer.play('rig_x_geroAction_001')
				$Idle.hide()
				$Jump.hide()
				$Walk.hide()


func _ready() -> void:
	current_anim = GeroAnimation.IDLE


func _on_animation_finished(anim_name: StringName) -> void:
	current_anim = GeroAnimation.FALLING
