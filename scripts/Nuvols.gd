extends ParallaxLayer

export(float) var Nuvol_velocitat = -5

func _process(delta) -> void: #Moviment del fons 
	self.motion_offset.x += Nuvol_velocitat * delta

func _ready():
	pass # Replace with function body.
