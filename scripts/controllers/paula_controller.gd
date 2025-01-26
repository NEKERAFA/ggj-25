extends Node3D
class_name Paula


enum PaulaFase { FASE_0, FASE_1, FASE_2 }

var current_anim:
	get:
		return current_anim
	
	set(value):
		current_anim = value
		
		match value:
			PaulaFase.FASE_0:
				$Fase0.show()
				$Fase1.hide()
				$Fase2.hide()
			
			PaulaFase.FASE_1:
				$Fase0.hide()
				$Fase1.show()
				$Fase1/AnimationPlayer.play('rig_x_paulaAction')
				$Fase2.hide()
			
			PaulaFase.FASE_2:
				$Fase0.hide()
				$Fase1.hide()
				$Fase2.show()
				$Fase2/AnimationPlayer.play('rig_x_paulaAction')


func _ready() -> void:
	current_anim = PaulaFase.FASE_0
