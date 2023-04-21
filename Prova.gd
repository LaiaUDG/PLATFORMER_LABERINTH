extends Node2D

const PEDRA:=preload("res://Escenes/Projectil.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Personatge_dispara(dreta, posicio):
	var p = PEDRA.instance()
	var vd:Vector2
	if dreta: vd = Vector2(1,0)
	else: vd = Vector2(-1,0)
	p.ini(vd, posicio)
	p.afegir_emissor($Personatge)
	add_child(p)
