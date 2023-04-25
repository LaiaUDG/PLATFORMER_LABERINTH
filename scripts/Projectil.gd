class_name Projectil extends Area2D
# bala amb moviment parabolic
# Al tocar qualsevol objecte amb collision shape desapareix. 

signal disparat(area) # area tocada
const GRAVETAT := 980
export var _vel:= 400 # píxels per segon 
var _tocables:= []    # éssers afectats per la bala (inj. de depend.)
var _emissors:= []    # éssers que disparen les bales 
var _vdir:= Vector2() # vector velocitat i direcció 

# inicialitzem el vector velocitat de la bala i la pos inicial
func ini(dir:Vector2, posIni: Vector2):
	position = posIni
	dir = dir.normalized()
	_vdir.x = dir.x * _vel
	_vdir.y = -_vel
	
# moviment de la bala 
func _process(delta:float):
	_vdir.y += GRAVETAT * delta 
	_vdir = _vdir.clamped(_vel)
	position += _vdir * delta

func afegir_tocable(esser:Node):
	_tocables.append(esser)
	
func afegir_emissor(esser:Node):
	_emissors.append(esser)

func _on_Projectil_body_entered(body:PhysicsBody2D):
	if not body in _emissors:
		queue_free() # Borrar projectil 
	
# si el cos tocat és a _tocables, l'elimina; en qualsevol cas, elimina 
func _on_Projectil_area_entered(area:Area2D):
	if area in _tocables:
		emit_signal("disparat",area)
	queue_free() # Borrar projectil

# per si s'escapa de la pantalla sense tocar res
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	


func _on_Projectil_disparat(area):
	pass # Replace with function body.
