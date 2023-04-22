extends PathFollow2D

signal atac
signal tocat
const PRIMER_texture:=preload("res://Sprites/Enemics/Enemic blau.png")
const SEGON_texture:=preload("res://Sprites/Enemics/Enemic rosa.png")
export var _Preses:=[]

export var vida = 2
export var _vel:= 30
export var SEGON:=false
export var pupa = false
export var state : String = "patrulla"
export (String, "loop", "linear") var tipus_patrulla = "linear"

var moviment:=false
var direction:=1

func patrulla(delta):
	if tipus_patrulla == "loop":
		offset += _vel * delta
	else:
		if	direction == 1:
			if (unit_offset == 1):
				$Area2D.scale.x=-1
				direction = 0
			else:
				offset += _vel * delta
		else:
			if unit_offset ==0:
				$Area2D.scale.x=1
				direction = 1
			else:
				offset -= _vel * delta

# Called when the node enters the scene tree for the first time.
func _ready():
	if(SEGON):
		$Area2D/Sprite.set_texture(SEGON_texture)
	else:
		$Area2D/Sprite.set_texture(PRIMER_texture)
	pupa=false

func _process(delta:float):
	if state == "quiet":
		$Area2D/AnimationPlayer.play("Idle")
	elif state == "patrulla":
		$Area2D/AnimationPlayer.play("Walk")
		patrulla(delta)
		

func pendre_mal(quant):
	print("Mal enemic")
	vida += quant
	if (vida <= 0):
		$Area2D/AnimationPlayer.play("Mort")
	else:
		$Area2D/AnimationPlayer.play("Mal")
	
		
func afegir_presa(el:Node):
	_Preses.append(el)
		
func _on_Enemic_body_entered(body: Node):
	if body in _Preses: # si és una víctima
		emit_signal("atac")
		vida += -1 
		if (vida <= 0):
			$Area2D/AnimationPlayer.play("Mort")
		else:
			$Area2D/AnimationPlayer.play("Mal")
	

