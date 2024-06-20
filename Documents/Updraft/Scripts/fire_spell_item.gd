extends Node2D

signal showinfo

var invslot

var draggable = false
var snap = true

var equipped = false
var equippable = false

#var invslots = get_tree().get_nodes_in_group("InvSlot")
var nearest_invslot

var oldpos = Vector2(0, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	
	
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if get_parent().inventoryopen == false and equipped == false:
		self.hide()
	else:
		self.show()
	
	if draggable == true and Input.is_action_pressed("click") and not (equipped == true and Global.melee == false) and get_parent().inventoryopen == true:
		global_position = get_global_mouse_position()
		equipped = false
		Global.spell = ""
	
	
	
	if draggable == true and Input.is_action_just_pressed("click"):
		if invslot >= 1:
			Global.inventory.append(invslot)
		invslot = 0
		
	
	#print(get_parent().get_parent().get_local_mouse_position())
	if Input.is_action_just_released("click") and snap == false and equippable == false:
		get_parent()._pickup(self)
	
	if Input.is_action_just_released("click") and equippable == true and Global.melee == true:
		Global.spell = "Fireball"
		equipped = true
	
	
	if equipped == true and not (draggable == true and Input.is_action_pressed("click")):
		self.position = get_parent().get_node("Magic").position
	if equipped == true and Global.melee == false:
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
	
	if snap == true and equipped == false and invslot == 0:
		self.scale.x = 0.8
		self.scale.y = 0.8
	elif equipped == false and equippable == false:
		self.scale.x = 1
		self.scale.y = 1
	
	#if snap == true:
	#	for i in invslots:
	#		if i.global_position.distance_to(self.global_position) < nearest_invslot.global_position.distance_to(self.global_position):
	#			nearest_invslot = i
	
	print(invslot)
	
	pass



func _on_area_2d_mouse_entered():
	
	if not (equipped == true and Global.melee == false):
		Global.fireballinfoshow = true  ######## DO iNFO SHOW IF HOVERING AND INV CLOSED IS OPENED ##############
	draggable = true
	Global.cantattack = true
	
	
	pass # Replace with function body.


func _on_area_2d_mouse_exited():
	
	Global.fireballinfoshow = false
	
	draggable = false
	Global.cantattack = false
	pass # Replace with function body.


func _on_area_2d_body_entered(body):
	
	if body.is_in_group("SpellSlot"):
		equippable = true
		self.scale.x = 0.8
		self.scale.y = 0.8
	
	pass # Replace with function body.


func _on_area_2d_body_exited(body):
	
	
	if body.is_in_group("SpellSlot"):
		equippable = false
		self.scale.x = 1
		self.scale.y = 1
	
	pass # Replace with function body.
	
func is_any_invslot_inside() -> bool:
	var overlapping_bodies = $Area2D.get_overlapping_bodies()
	for body in overlapping_bodies:
		if body.is_in_group("InvSlot"):
			if invslot == 0 and not Input.is_action_pressed("click"):
				self.position = body.position
				
				if self.position.y == -8:
					Global.inventory.pop_at((self.position.x - 122) / 20)
					invslot = ((self.position.x - 122) / 20) + 1
				elif self.position.y == 12:
					Global.inventory.pop_at(((self.position.x - 122) / 20) + 9)
					invslot = ((self.position.x - 122) / 20) + 10
				elif self.position.y == 32:
					Global.inventory.pop_at(((self.position.x - 122) / 20) + 18)
					invslot = ((self.position.x - 122) / 20) + 19
					
			return true
	return false
