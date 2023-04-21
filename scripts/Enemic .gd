extends Area2D

signal atac
signal tocat

export var _Preses:=[]

export var vida = 2
export var _vel:= 30

export var pupa = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _process(delta:float):
	if (!pupa):
		$AnimationPlayer.play("Idle")

func pendre_mal(quant):
	vida =+ quant
	if (vida <= 0):
		$AnimationPlayer.play("Mort")
	else:
		$AnimationPlayer.play("Mal")
	
		
func afegir_presa(el:Node):
	_Preses.append(el)
		
func _on_Enemic_body_entered(body: Node):
	if body in _Preses: # si és una víctima
		emit_signal("atac")
		vida += -1 
		if (vida <= 0):
			$AnimationPlayer.play("Mort")
		else:
			$AnimationPlayer.play("Mal")
	

