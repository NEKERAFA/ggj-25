extends Node3D
class_name Lila


enum LilaFase { FASE_0, FASE_1, FASE_2 }

var current_anim:
	get:
		return current_anim
	
	set(value):
		current_anim = value
		
		match value:
			LilaFase.FASE_0:
				$Fase0.show()
				$Fase1.hide()
				$Fase2.hide()
			
			LilaFase.FASE_1:
				$Fase0.hide()
				$Fase1.show()
				$Fase1/AnimationPlayer.play('KeyAction')
				$Fase2.hide()
			
			LilaFase.FASE_2:
				$Fase0.hide()
				$Fase1.hide()
				$Fase2.show()
				$Fase2/AnimationPlayer.play('KeyAction')


func _ready() -> void:
	current_anim = LilaFase.FASE_0
