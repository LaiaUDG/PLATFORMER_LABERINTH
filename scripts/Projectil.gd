class_name Projectil extends Area2D
# bala amb moviment rectilini uniforme
# quan toca un enemic el mata i desapareix; si toca un StaticBody o 
# surt d'escena, també desapareix 

signal disparat(area) # area tocada
const GRAVETAT := 680
export var _vel:= 400 # píxels per segon 
var _tocables:= []    # éssers afectats per la bala (inj. de depend.)
var _emissors:= []    # éssers que disparen les bales 
var _vdir:= Vector2() # vector velocitat

# inicialitzem el vector velocitat de la bala i la pos inicial
func ini(dir:Vector2, posIni: Vector2):
	position = posIni
	dir = dir.normalized()
	_vdir.x = dir.x * _vel
	_vdir.y = -_vel
	print("Ini Projectil")
	
# moviment de la bala 
func _process(delta:float):
	_vdir.y += GRAVETAT * delta 
	_vdir = _vdir.clamped(_vel)
	position += _vdir * delta

func afegir_tocable(esser:Node):
	print("nou toc")
	_tocables.append(esser)
	
func afegir_emissor(esser:Node):
	_emissors.append(esser)

func _on_Projectil_body_entered(body:PhysicsBody2D):
	if not body in _emissors:
		queue_free() # eliminem la bala
	
# si el cos tocat és a _tocables, l'elimina; en qualsevol cas, elimina la bala
func _on_Projectil_area_entered(area:Area2D):
	print("Area2d pedra")
	if area in _tocables:
		print("Tocable")
		emit_signal("disparat",area)
	queue_free() # eliminem la bala

# per si s'escapa de la pantalla sense tocar res
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	


func _on_Projectil_disparat(area):
	pass # Replace with function body.
