class_name Mon extends Node2D
# nivell
const PEDRA:=preload("res://Escenes/Projectil.tscn")
var _pers:Personatge

# injectarem qui pot recollir les monedes
func _ready():
	$goal.visible = 0
	var codi_inici = $"/root/Inici"
	_pers = codi_inici._jugador
	# important configurar abans d'afegir a arbre de nodes !
	_pers.set_name("Personatge")
	_pers.set_pos_inicial($puntInici.position)  
	add_child(_pers)  # afegim personatge a l'escena
	_pers.connect("dispara", self, "_on_personatge_dispara")
	get_tree().call_group("Pomes", "afegir_recollidor", $Personatge) 
	get_tree().call_group("Monedes", "afegir_recollidor", $Personatge) 
	get_tree().call_group("Enemics", "afegir_presa", $Personatge) 
	$goal.afegir_assolidor($Personatge)

func _on_personatge_dispara(aDreta:bool, posicio:Vector2):
	var p = PEDRA.instance()
	var vd:Vector2
	if aDreta: vd = Vector2(1,0)
	else: vd = Vector2(-1,0)
	p.ini(vd, posicio)
	p.afegir_emissor($Personatge)
	for enemic in get_tree().get_nodes_in_group("Enemics"):
		p.afegir_tocable(enemic.get_child(0))
	p.connect("disparat", self, "_on_Projectil_disparat")
	add_child(p,true)
 

func _on_Projectil_disparat(area):
	print("disparat")
	if area.get_parent(): # si té pare, si no és null
		var e = area.get_parent()
		print("fill")
		if e.is_in_group("Enemics"):
			print("enemic") 
			e.pendre_mal(-1)


# tocarà canvi de nivell
func _on_goal_objectiu_assolit(esser:Node):
	remove_child(_pers) # per tal de mantenir-lo
	$"/root/Inici".seguent_niv()
	# aquí ha de mostrar pantalla de GUANYAT

func _on_Galeta_recollida(algu:Node):
	var pers:= algu as Personatge
	pers.omplir_energia()
	print(get_tree().get_nodes_in_group("Monedes").size())
	if (get_tree().get_nodes_in_group("Monedes").size()==1):
		print("Conseguit")
		$goal.visible = 1
		$goal.apareixer()
	
func _on_Galeta_vida(algu:Node):
	print(algu)
	var pers:=algu as Personatge
	pers.suma_vides(1)
	
func _on_Area2D_tocat():
	print("Aigua")
	_pers.suma_vides(-1)


func _on_Enemic_atac():
	_pers.suma_vides(-1)


