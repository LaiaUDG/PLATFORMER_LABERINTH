extends Node

const NIVELLS := 3

const ESC_PERS:= preload("res://Escenes/Personatge.tscn")
const NIV_1:=preload("res://Escenes/World.tscn")
const NIV_2:=preload("res://Escenes/World2.tscn")
const NIV_3:=preload("res://Escenes/World3.tscn")

var _nivells:Array
var _jugador:Personatge
var _nivActual:int

# Called when the node enters the scene tree for the first time.
func _init():
	_nivActual = 1
	_nivells.append(NIV_1)
	_nivells.append(NIV_2)
	_nivells.append(NIV_3)
	_jugador = ESC_PERS.instance()
	print("_jugador: ", _jugador)

func seguent_niv():
	_nivActual += 1
	if _nivActual > NIVELLS:
		print("Victoria")
	else:
		SceneTree.set_current_scene(_nivells[_nivActual])
		
		s#canviar escena victoria

