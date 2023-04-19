class_name Mon extends Node2D
# nivell

var ESC_PERS:= preload("res://Personatge.tscn")
var _pers:Personatge

# injectarem qui pot recollir les monedes
func _ready():
	$goal.visible = 0
	_pers = ESC_PERS.instance()
	# important configurar abans d'afegir a arbre de nodes !
	_pers.set_name("Personatge")
	_pers.set_pos_inicial($puntInici.position)  
	add_child(_pers)  # afegim personatge a l'escena
	get_tree().call_group("Monedes", "afegir_recollidor", $Personatge) 
	$goal.afegir_assolidor($Personatge)



# tocarà canvi de nivell
func _on_goal_objectiu_assolit(esser:Node):
	$goal.visible = 1
	$goal.apareixer()
	# aquí ha de mostrar pantalla de GUANYAT

func _on_Galeta_recollida(algu:Node):
	var pers:= algu as Personatge
	pers.suma_vides(1)
