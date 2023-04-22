extends Node2D



func _ready():
	var i = 1	
	var sprite = 'Sprite' + str(i)
	while i<4:
		var node = get_node(sprite)
		node.visible = 0

func mostrar(numero):
	var i = 1	
	var sprite = 'Sprite' + str(i)
	while i<numero:
		var node = get_node(sprite)
		node.visible = 1
	if numero>3:
		Label.text="Has guanyat"
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
