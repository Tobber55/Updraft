extends Sprite2D
var melee = true
var mageoccupied = false #ONCE WEPON IS IN IT
var meleeoccupied = false
var inventoryopen = false #FOR ITEMS

const firespellitem = preload("res://Scenes/Items/Weapons/Magic/fire_spell_item.tscn")




# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	if Input.is_action_just_pressed("ui_inv"):
		inventoryopen = !(inventoryopen)
	
	if inventoryopen == true:
		$Inventory.show()
	else:
		$Inventory.hide()
	
	if mageoccupied == true:
		$Magic.texture = load("res://Textures/UI/Blank.png")
	if meleeoccupied == true:
		$Melee.texture = load("res://Textures/UI/Blank.png")
	
	$Stamina.value = Global.stamina 
	$Health.value = Global.health
	$XP.value = Global.xp
	
	if Input.is_action_just_pressed("ui_switch"):
		melee = !(melee)
	if melee == true:
		$Melee.position.x = 263
		$Melee.position.y = 152
		$Melee.scale.x = 0.35
		$Melee.scale.y = 0.35
		$Magic.position.x = 281
		$Magic.position.y = 170
		$Magic.scale.x = 0.25
		$Magic.scale.y = 0.25
	if melee == false:
		$Magic.position.x = 263
		$Magic.position.y = 152
		$Magic.scale.x = 0.35
		$Magic.scale.y = 0.35
		$Melee.position.x = 281
		$Melee.position.y = 170
		$Melee.scale.x = 0.25
		$Melee.scale.y = 0.25
	
	pass
	
func _pickup(x):
	if Global.inventory[0] == 1:
		x.position.x = 122
		x.position.y = -8
		Global.inventory.pop_at(0)
	elif Global.inventory[0] == 2:
		x.position.x = 142
		x.position.y = -8
		Global.inventory.pop_at(0)
	elif Global.inventory[0] == 3:
		x.position.x = 162
		x.position.y = -8
		Global.inventory.pop_at(0)
	elif Global.inventory[0] == 4:
		x.position.x = 182
		x.position.y = -8
		Global.inventory.pop_at(0)
	elif Global.inventory[0] == 5:
		x.position.x = 202
		x.position.y = -8
		Global.inventory.pop_at(0)
	elif Global.inventory[0] == 6:
		x.position.x = 222
		x.position.y = -8
		Global.inventory.pop_at(0)
	elif Global.inventory[0] == 7:
		x.position.x = 242
		x.position.y = -8
		Global.inventory.pop_at(0)
	elif Global.inventory[0] == 8:
		x.position.x = 262
		x.position.y = -8
		Global.inventory.pop_at(0)
	elif Global.inventory[0] == 9:
		x.position.x = 282
		x.position.y = -8
		Global.inventory.pop_at(0)
	elif Global.inventory[0] == 10:
		x.position.x = 122
		x.position.y = 12
		Global.inventory.pop_at(0)
	elif Global.inventory[0] == 11:
		x.position.x = 142
		x.position.y = 12
		Global.inventory.pop_at(0)
	elif Global.inventory[0] == 12:
		x.position.x = 162
		x.position.y = 12
		Global.inventory.pop_at(0)
	elif Global.inventory[0] == 13:
		x.position.x = 182
		x.position.y = 12
		Global.inventory.pop_at(0)
	elif Global.inventory[0] == 14:
		x.position.x = 202
		x.position.y = 12
		Global.inventory.pop_at(0)
	elif Global.inventory[0] == 15:
		x.position.x = 222
		x.position.y = 12
		Global.inventory.pop_at(0)
	elif Global.inventory[0] == 16:
		x.position.x = 242
		x.position.y = 12
		Global.inventory.pop_at(0)
	elif Global.inventory[0] == 17:
		x.position.x = 262
		x.position.y = 12
		Global.inventory.pop_at(0)
	elif Global.inventory[0] == 18:
		x.position.x = 282
		x.position.y = 12
		Global.inventory.pop_at(0)
	elif Global.inventory[0] == 19:
		x.position.x = 122
		x.position.y = 32
		Global.inventory.pop_at(0)
	elif Global.inventory[0] == 20:
		x.position.x = 142
		x.position.y = 32
		Global.inventory.pop_at(0)
	elif Global.inventory[0] == 21:
		x.position.x = 162
		x.position.y = 32
		Global.inventory.pop_at(0)
	elif Global.inventory[0] == 22:
		x.position.x = 182
		x.position.y = 32
		Global.inventory.pop_at(0)
	elif Global.inventory[0] == 23:
		x.position.x = 202
		x.position.y = 32
		Global.inventory.pop_at(0)
	elif Global.inventory[0] == 24:
		x.position.x = 222
		x.position.y = 32
		Global.inventory.pop_at(0)
	elif Global.inventory[0] == 25:
		x.position.x = 242
		x.position.y = 32
		Global.inventory.pop_at(0)
	elif Global.inventory[0] == 26:
		x.position.x = 262
		x.position.y = 32
		Global.inventory.pop_at(0)
	elif Global.inventory[0] == 27:
		x.position.x = 282
		x.position.y = 32
		Global.inventory.pop_at(0)
		




func _on_character_body_2d_pickupfirespell():
	var place = firespellitem.instantiate()
	add_child(place)
	_pickup(place)
	
	pass # Replace with function body.
