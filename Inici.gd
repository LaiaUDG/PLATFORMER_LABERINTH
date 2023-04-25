extends Node

const NIVELLS := 3
const ESC_PERS:= preload("res://Escenes/Personatge.tscn")
const NIV_1:=preload("res://Escenes/World.tscn")
const NIV_2:=preload("res://Escenes/World2.tscn")
const NIV_3:=preload("res://Escenes/World3.tscn")
const FINAL:=preload("res://Pantalla_final.tscn")

var _nivells:Array
var _jugador:Personatge
var _nivActual:int
export var _temps = 120

# Called when the node enters the scene tree for the first time.
func _init():
	_nivActual = 1
	_nivells.append(NIV_1)
	_nivells.append(NIV_2)
	_nivells.append(NIV_3)
	_jugador = ESC_PERS.instance()
	
	
func seguent_niv():
	_jugador.seguent_niv()
	_nivActual += 1
	if _nivActual > NIVELLS: #
		get_tree().change_scene_to(FINAL)
	else:
		get_tree().change_scene_to(_nivells[_nivActual-1])
		
func pantalla_final():
	get_tree().change_scene_to(FINAL)

#cada segon es crida, actualitza el temps que queda per a completar el nivell final
func Actualitza_temps():
	if _temps > 0:	
		print(_temps)
		_temps=_temps-1
		get_tree().get_nodes_in_group("Temps")[0].text=String(_temps/60)+":"+String(_temps%60)
		print(String(_temps/60)+":"+String(_temps%60))
	else:
		#segon.stop()
		_jugador.Mort()
		_temps=10
		
#Reinicia el joc	
func Restart():
	_init()
	_nivActual = 1
	get_tree().change_scene_to(_nivells[_nivActual-1])
	
	
	
