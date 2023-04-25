extends Node2D

#Pantalla final, es mostra quan el jugador passa de nivell o mort, serveix per a treire el joc o fer restart

const Blau:=preload("res://Sprites/Enemics/medalla.png")
const Verd:= preload("res://Sprites/Enemics/medalla3.png")
const Vermell:= preload("res://Sprites/Enemics/medalla2.png")


func _ready():
	var numero = $"/root/Inici"._nivActual
	if numero>3:
		$Sprite1.set_texture(Blau)
		$Sprite2.set_texture(Verd)
		$Sprite3.set_texture(Vermell)
		$Label.text="Has guanyat"
	else:	
		var i = 1
		var sprite = 'Sprite' + str(i)
		var Max = $"/root/Inici".NIVELLS
		$Label.text="Has perdut"
		if numero==1:
			$Sprite1.visible=0
			$Sprite2.visible=0
			$Sprite3.visible=0
		elif numero==2:
			$Sprite3.set_texture(Blau)
			$Sprite1.visible=0
			$Sprite2.visible=0
			$Sprite3.visible=1
		else:
			$Sprite1.set_texture(Blau)
			$Sprite2.set_texture(Verd)
			$Sprite1.visible=1
			$Sprite2.visible=1
			$Sprite3.visible=0

func _on_Surt_pressed(): #per a sortir del joc
	get_tree().quit()

func _on_Jugar_pressed():#crida a metode de la singleton
	Inici.Restart()
