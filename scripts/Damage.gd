extends Area2D
#Per a detectar quan el jugador cau a l'aigua
signal tocat

func _ready():
	pass # Replace with function body.

func _on_Area2D_body_entered(body):
	if body is Personatge:
		emit_signal("tocat")
	
