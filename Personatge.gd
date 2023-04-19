class_name Personatge extends KinematicBody2D
# un personatge  d'un joc de plataformes dirigit pel jugador

const NORMAL := Vector2(0,-1)
const GRAVETAT := 20
const MAX_VEL_CAIGUDA := 200
const MAX_VELOC := 150
const VEL_SALT := -600
const ACCEL_X := 20  # efecte desitjat 

# atributs
var _vel := Vector2()     # velocitat actual
var _mirantADreta = true  # la textura per defecte mira a dreta
var _posInicial: Vector2  # posició on comença el nivell
export var _nvides:= 3 
export var _energia:=10
var _caient := false # indica si el personatge està caient

# inicialitzem posició inicial i etiqueta on mostra nombre de vides
func _ready():
	$Label.set_text("VIDES: "+str(_nvides))
	
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
		_vel.x += ACCEL_X
		_mirantADreta = true  # encara que segueixi movent-se a esquerra
		$AnimationPlayer.play("Run")
	elif Input.is_action_pressed("ui_left"):
		_vel.x += -ACCEL_X   
		_mirantADreta = false  # encara que segueixi movent-se a dreta
		$AnimationPlayer.play("Run")
	else: 
		_vel.x = lerp(_vel.x, 0, 0.2) # interp. lineal 
		$AnimationPlayer.play("Idle")
		
	if is_on_floor():
		if Input.is_action_just_pressed("salta"):
			#var Salt = Timer.new()
			#Salt.set_wait_time(0.3)
			#Salt.set_one_shot(true)
			#self.add_child(Salt)
			#Salt.start();
			#yield(Salt, "timeout")
			_vel.y = VEL_SALT # no sumem, assignem
			#$AnimationPlayer.play("Jump")
	else:
		if _vel.y < 0: # està pujant 
			$AnimationPlayer.play("Jump")
		elif _vel.y > 0: # està caient
			$AnimationPlayer.play("fall")
	
	_vel = move_and_slide(_vel, NORMAL)
		
# nv >= -1 ; modifica i mostra nombre final de vides; fa respawn si ha perdut vida
func suma_vides(nv:int):
	_nvides += nv
	if _nvides < 0:
		pass
		# pantalla inicial mode fail 
	elif nv < 0: # ha perdut una vida
		 yield(get_tree().create_timer(0.5), "timeout")
		 respawn()
	$Label.set_text("")
	$Label.set_text("VIDES: "+str(_nvides))
	
# torna a posar el personatge a la posicio inicial		
func respawn():
	position = _posInicial
	_mirantADreta = true
	_vel = Vector2()   # aturat 
