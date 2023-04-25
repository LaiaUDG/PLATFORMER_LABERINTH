class_name Moneda extends Area2D
# una moneda dins el nivell, per ser recollida per algú 

var _recollidors:Array  # aquí s'injectaran els personatges que poden recollir galetes
const POMA:=preload("res://Sprites/poma.png")
const Cookie:=preload("res://Sprites/cookie.png")
export var VIDES:=false 

signal recollida(algu)  # algú ha recollit la moneda
signal vida(algu)

func _ready():
	if (VIDES):
		$Sprite.set_texture(POMA)
		scale.x = 0.3
		scale.y = 0.3
	else: 
		$Sprite.set_texture(Cookie)
		scale.x= 0.2
		scale.y= 0.2
		
# si un recollidor passa per la moneda, aquesta desapareix i s'avisa cap amunt
func _on_moneda_body_entered(body: Node):
	if body in _recollidors: # si té capacitat de recollir moneda
		if(VIDES):#Si es de tipus vides enviarem un signal diferent per a pujar vides del jugador
			emit_signal("vida",body)
		else:
			emit_signal("recollida", body)
			remove_from_group("Monedes")
		queue_free()
		
# incorpora <reco> com a personatge que pot recollir la moneda
func afegir_recollidor(reco:Node):		
	_recollidors.append(reco)
