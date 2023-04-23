class_name Goal extends Area2D
# un punt objectiu a assolir

signal objectiu_assolit(esser)
var mostrar = false

var _assolidors:= []  # aquí injectarem els qui podran assolir objectiu 



func afegir_assolidor(asso:Node):
	_assolidors.append(asso)
	
func apareixer():
	$AnimationPlayer.play("apareixer")
	yield(get_node("AnimationPlayer"), "animation_finished")
	mostrar = true

func _process(delta:float):
	if (mostrar):
		$AnimationPlayer.play("idle")


# quan hi entri algú, mirarem si és dels "interessats"
func _on_goal_body_entered(body: Node):
	if body in _assolidors:
		if (mostrar):
			emit_signal("objectiu_assolit", body)
