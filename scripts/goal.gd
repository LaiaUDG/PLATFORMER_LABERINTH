class_name Goal extends Area2D
# un punt objectiu a assolir

signal objectiu_assolit(esser)
export var mostrar = false

var _assolidors:= []  # qui pot passar el portal

func afegir_assolidor(asso:Node):
	_assolidors.append(asso)
	
#fer apareixer el portal per pantalla
func apareixer():
	$AnimationPlayer.play("apareixer")

func _process(delta:float):
	if (mostrar):
		$AnimationPlayer.play("idle")

# quan hi entri algú, mirarem si és dels "interessats"
func _on_goal_body_entered(body: Node):
	if body in _assolidors:
		if (mostrar): #Si es mostra per pantalla podrem passar de nivell
			emit_signal("objectiu_assolit", body)
