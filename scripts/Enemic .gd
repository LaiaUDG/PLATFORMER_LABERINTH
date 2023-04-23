extends PathFollow2D

signal atac
signal tocat
const PRIMER_texture:=preload("res://Sprites/Enemics/Enemic blau.png")
const SEGON_texture:=preload("res://Sprites/Enemics/Enemic rosa.png")
export var _Preses:=[]
var pupa = false
export var vida = 2
export var _vel:= 30
export var SEGON:=false
export var state : String = "patrulla"
var climb = false
export (String, "loop", "linear") var tipus_patrulla = "linear"

var moviment:=false
var direction:=1
var anterior = ""

func patrulla(delta):
	if tipus_patrulla == "loop":
		offset += _vel * delta
	else:
		if	direction == 1:
			if (unit_offset == 1):
				$Enemic/Pausa.start()
				state="quiet"
				$Enemic/AnimationPlayer.play("Idle")
				yield($Enemic/Pausa, "timeout")
				$Enemic.scale.x=-1
				direction = 0
			else:
				offset += _vel * delta
		else:
			if unit_offset ==0:
				$Enemic/Pausa.start()
				state="quiet"
				$Enemic/AnimationPlayer.play("Idle")
				yield($Enemic/Pausa, "timeout")
				$Enemic.scale.x=1
				direction = 1
			else:
				offset -= _vel * delta

func Escala(delta):
	if tipus_patrulla == "loop":
		offset += _vel * delta
	else:
		if	direction == 1:
			if (unit_offset == 1):
				direction = 0
			else:
				offset += _vel * delta
		else:
			if unit_offset ==0:
				$Enemic/Pausa.start()
				state="quiet"
				$Enemic/AnimationPlayer.play("Idle")
				yield($Enemic/Pausa, "timeout")
				direction = 1
			else:
				offset -= _vel * delta
	

# Called when the node enters the scene tree for the first time.
func _ready():
	if(SEGON):
		$Enemic/Sprite.set_texture(SEGON_texture)
	else:
		$Enemic/Sprite.set_texture(PRIMER_texture)
	if state=="climb":
		climb=true


func _process(delta:float):
		if state=="anterior":
			state=anterior
		if state == "quiet":
			$Enemic/AnimationPlayer.play("Idle")
		elif state == "patrulla":
			$Enemic/AnimationPlayer.play("Walk")
			patrulla(delta)
		elif state == "climb":
			$Enemic/AnimationPlayer.play("Climb")
			Escala(delta)

func pendre_mal(quant):
	vida += quant
	anterior=state
	if (vida <= 0):
		$Enemic/AnimationPlayer.play("Mort")
	else:
		$Enemic/AnimationPlayer.play("Mal")
	
		
func afegir_presa(el:Node):
	_Preses.append(el)
		
func _on_Enemic_body_entered(body: Node):
	if body in _Preses: # si és una víctima
		emit_signal("atac")
		vida += -1 
		anterior = state
		if (vida <= 0):
			$Enemic/AnimationPlayer.play("Mort")
			pupa=true
		else:
			$Enemic/AnimationPlayer.play("Mal")
	

func _on_Pausa_timeout():
	if !pupa:
		if climb:
			state = "climb"
		else:
			state = "patrulla"
