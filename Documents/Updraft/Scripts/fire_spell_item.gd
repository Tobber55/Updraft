extends Node2D

signal showinfo

var invslot

var draggable = false
var snap = true

var equipped = false
var equippable = false

var oldpos = Vector2(0, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	
	
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if get_parent().inventoryopen == false:
		self.hide()
	else:
		self.show()
	
	if draggable == true and Input.is_action_pressed("click"):
		global_position = get_global_mouse_position()
	
	if draggable == true and Input.is_action_just_pressed("click"):
		if invslot >= 1:
			Global.inventory.append(invslot)
		invslot = 0
		
	
	#print(get_parent().get_parent().get_local_mouse_position())
	if Input.is_action_just_released("click") and snap == false and equipped == false:
		get_parent()._pickup(self)
	
	if Input.is_action_just_released("click") and equippable == true:
		Global.spell = "Fireball"
		equipped = true
	
	
	if equipped == true:
		self.position = get_parent().get_node("Magic").position
	if Global.melee == false and equipped == true:
		self.scale.x = 0.714
		self.scale.y = 0.714
		self.z_index = 0
	elif equipped == true:
		self.scale.x = 1
		self.scale.y = 1
		self.z_index = 1
	
	snap = is_any_invslot_inside()
	
	print(equipped) #### DO UNEQUIP NEXT
	
	pass



func _on_area_2d_mouse_entered():
	
	Global.fireballinfoshow = true
	draggable = true
	
	pass # Replace with function body.


func _on_area_2d_mouse_exited():
	
	Global.fireballinfoshow = false
	
	draggable = false
	pass # Replace with function body.


func _on_area_2d_body_entered(body):
	
	if body.is_in_group("SpellSlot"):
		equippable = true
		
	
	pass # Replace with function body.


func _on_area_2d_body_exited(body):
	
	
	if body.is_in_group("SpellSlot"):
		equippable = false
	
	pass # Replace with function body.
	
func is_any_invslot_inside() -> bool:
	var overlapping_bodies = $Area2D.get_overlapping_bodies()
	for body in overlapping_bodies:
		if body.is_in_group("InvSlot"):
			return true
	return false
