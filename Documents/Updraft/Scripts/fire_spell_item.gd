extends Node2D

signal showinfo

var invslot

# Called when the node enters the scene tree for the first time.
func _ready():
	
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if get_parent().inventoryopen == false:
		self.hide()
	else:
		self.show()
	
	print(invslot)
	
	pass



func _on_area_2d_mouse_entered():
	
	Global.fireballinfoshow = true
	
	pass # Replace with function body.


func _on_area_2d_mouse_exited():
	
	Global.fireballinfoshow = false
	
	pass # Replace with function body.
