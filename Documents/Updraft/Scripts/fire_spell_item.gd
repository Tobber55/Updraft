extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	
	print(1)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if get_parent().inventoryopen == false:
		self.hide()
	else:
		self.show()
	
	
	
	pass


func _on_area_2d_showinfo():
	
	
	pass # Replace with function body.