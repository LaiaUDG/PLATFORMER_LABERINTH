class_name Moneda extends Area2D
# una moneda dins el nivell, per ser recollida per algú 

var _recollidors:Array  # aquí s'injectaran els personatges que poden recollir monedes
# (injecció de dependència)

signal recollida(algu)  # algú ha recollit la moneda

# si un recollidor passa per la moneda, aquesta desapareix i s'avisa cap amunt
func _on_moneda_body_entered(body: Node):
	if body in _recollidors: # si té capacitat de recollir moneda
		emit_signal("recollida", body)
		remove_from_group("Monedes")
		queue_free()
		
# incorpora <reco> com a personatge que pot recollir la moneda
func afegir_recollidor(reco:Node):		
	_recollidors.append(reco)
