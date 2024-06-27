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
	
	if Global.spell != "":
		$Magic/Sprite2D.texture = preload("res://Textures/UI/Blank.png")
	else:
		$Magic/Sprite2D.texture = preload("res://Textures/UI/Magic.png")
		
	if Global.meleeattack != "":
		$Melee/Sprite2D.texture = preload("res://Textures/UI/Blank.png")
	else:
		$Melee/Sprite2D.texture = preload("res://Textures/UI/Melee.png")
	
	pass
	
	
	_iteminfo()
	
func _pickup(x):
	
	if not len(Global.inventory) == 0:
		for i in Global.inventory:
			if i <= 9 and Global.inventory[0] == i:
				x.position.x = 122 + (20 * (i - 1))
				x.position.y = -8
				x.invslot = i
				Global.inventory.pop_at(0)
				break
			elif i <= 18 and Global.inventory[0] == i:
				x.position.x = 122 + (20 * (i - 10))
				x.position.y = 12
				x.invslot = i
				Global.inventory.pop_at(0)
				break
			elif i <= 27 and Global.inventory[0] == i:
				x.position.x = 122 + (20 * (i - 19))
				x.position.y = 32
				x.invslot = i
				Global.inventory.pop_at(0)
				break
		
	
	
		

func _iteminfo():
	if Global.fireballinfoshow == true and inventoryopen == true:
		$ItemInfo.show()
		$Title.show()
		$Description.show()
		$Title.text = "Fireball"
		$Description.text = "6 Damage\nBurning Effect\nFire Typing\nSellable"
	else:
		$ItemInfo.hide()
		$Title.hide()
		$Description.hide()
		$Title.text = ""
		$Description.text = ""
		Global.fireballinfoshow = false


func _on_character_body_2d_pickupfirespell():
	var place = firespellitem.instantiate()
	add_child(place)
	_pickup(place)
	
	pass # Replace with function body.
