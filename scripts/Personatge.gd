class_name Personatge extends KinematicBody2D
# un personatge  d'un joc de plataformes dirigit pel jugador

const NORMAL := Vector2(0,-1)
const GRAVETAT := 20
const MAX_VEL_CAIGUDA := 200
const MAX_VELOC := 150
const VEL_SALT := -600
const ACCEL_X := 20  # efecte desitjat 
const MAX_VIDES := 6
const CorApagat:=preload("res://Sprites/Cor.png")
const CorBrilla:=preload("res://Sprites/Cor2.png")

onready var Pos_Ma = $Ma

# atributs
var _vel := Vector2()     # velocitat actual
var _mirantADreta = true  # la textura per defecte mira a dreta
var _posInicial: Vector2  # posició on comença el nivell
export var _nvides:= 3 
export var _maxvides:=3 #en el nivell 1=3, nivvell2 =4; nivell3=6
var _caient := false # indica si el personatge està caient
var _Dispara = false
var _immobil = false
var _enmoviment = false
var niv = 1
signal dispara(dreta, posicio)
# inicialitzem posició inicial i etiqueta on mostra nombre de vides
func _ready():
	var i=_maxvides+1
	$HUD/Energia.value=100
	while i <= MAX_VIDES:
		var sprite = 'HUD/Sprite' + str(i)
		var node = get_node(sprite)
		node.visible = 0
		i+=1
	$Estamina.start()
# injectem la posició inicial
func set_pos_inicial(pos:Vector2):
	print(pos)
	position = pos
	_posInicial = pos # per quan es faci respawn 	

func _physics_process(delta:float):
	_vel.y += GRAVETAT # la gravetat va incrementant velocitat de caiguda 
	if _vel.y > MAX_VEL_CAIGUDA:
		_vel.y = MAX_VEL_CAIGUDA
		
	if _mirantADreta:
		$Sprite.scale.x = 1 # el posem normal (no sabem com estava)
	else: 
		$Sprite.scale.x = -1 # el posem girat (no sabem com estava)	
		
	_vel.x = clamp(_vel.x, -MAX_VELOC, MAX_VELOC)
	
	if Input.is_action_pressed("ui_right"):
		if (!_immobil and !_Dispara):
			_enmoviment=true
			_vel.x += ACCEL_X
			_mirantADreta = true  # encara que segueixi movent-se a esquerra
			if (!_caient):
				$AnimationPlayer.play("Run")
	elif Input.is_action_pressed("ui_left"):
		if (!_immobil and !_Dispara):
			_enmoviment=true
			_vel.x += -ACCEL_X   
			_mirantADreta = false  # encara que segueixi movent-se a dreta
			if (!_caient):
				$AnimationPlayer.play("Run")
	else: 
		if (!_immobil and !_Dispara):
			_enmoviment=false
			_vel.x = lerp(_vel.x, 0, 0.2) # interp. lineal 
			if (!_caient):
				$AnimationPlayer.play("Idle")
		
	if is_on_floor():
		_caient=false
		if Input.is_action_just_pressed("salta"):
			if (!_immobil and !_Dispara):
				$AnimationPlayer.play("Jump")
				_vel.y = VEL_SALT # no sumem, assignem
				_caient=true
				$HUD/Energia.value = $HUD/Energia.value-10
	else:
		_enmoviment=false
		if _vel.y < 0: # està pujant 
			_caient=true
		elif _vel.y > 0: # està caient
			_caient=true
			if (!_immobil):
				$AnimationPlayer.play("fall")
		else:
			_caient=false
	
	if !_Dispara and !_caient and Input.is_action_just_pressed("Disparar"):
		_Dispara = true
		$AnimationPlayer.play("Atac")
		$HUD/Energia.value = $HUD/Energia.value - 5
		$Disparar.start()
	
	if (!_immobil and !_Dispara):
		_vel = move_and_slide(_vel, NORMAL)
		
# nv >= -1 ; modifica i mostra nombre final de vides; fa respawn si ha perdut vida
func suma_vides(nv:int):	
	var sprite = 'HUD/Sprite' + str(_nvides)
	var node = get_node(sprite)
	_nvides += nv
	if _nvides == 0:
		_immobil = true
		node.set_texture(CorApagat)
		$AnimationPlayer.play("Mort")
		# pantalla inicial mode fail 
	elif nv < 0: # ha perdut una vida
		node.set_texture(CorApagat)
		respawn()
	else:
		sprite = 'HUD/Sprite' + str(_nvides)
		node = get_node(sprite)
		node.set_texture(CorBrilla)
		
func omplir_energia():
	$HUD/Energia.value=100

func disparar():
	emit_signal("dispara",_mirantADreta,Pos_Ma.global_position)

# torna a posar el personatge a la posicio inicial		
func respawn():
	_immobil = true
	$AnimationPlayer.play("Dany")
	yield($AnimationPlayer,"animation_finished")
	_immobil=false
	position = _posInicial
	_mirantADreta = true
	_vel = Vector2()   # aturat 
	$HUD/Energia.value = 100

func _on_Disparar_timeout():
	_Dispara=false


func _on_Estamina_timeout():
	if(_enmoviment):
		$HUD/Energia.value = $HUD/Energia.value - 1		
	$Estamina.start()

func _on_Energia_value_changed(value):
	 if ($HUD/Energia.value <= $HUD/Energia.min_value):
			suma_vides(-1)
			
func seguent_niv():
	niv+=1
	if (niv<=3):
		$HUD/Label.text=str(niv)
