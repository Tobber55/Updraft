extends Area2D

signal showinfo

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("click"):
		#Use An Item
		pass
