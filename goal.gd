class_name Goal extends Area2D
# un punt objectiu a assolir

signal objectiu_assolit(esser)

var _assolidors:= []  # aquí injectarem els qui podran assolir objectiu 

func afegir_assolidor(asso:Node):
	_assolidors.append(asso)

# quan hi entri algú, mirarem si és dels "interessats"
func _on_goal_body_entered(body: Node):
	print(body)
	print(body.position)
	print(position)
	if body in _assolidors:
		emit_signal("objectiu_assolit", body)
