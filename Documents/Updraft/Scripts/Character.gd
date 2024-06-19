extends CharacterBody2D

#Movement
var speed = 400.0
var accel = 1500
const friction = 600
var input = Vector2.ZERO
var flyspeed = -400.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
const maxfallspeed = 1000
#Actions
var sprint = false
var walking = false
var flying = false

var cooldown = 0

const fireball = preload("res://Scenes/Attacks/Fire.tscn")

signal pickupfirespell

func get_input():
	input.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	return input.normalized()

func player_movement(delta):
	
	# Adds the gravity.
	if Input.is_action_pressed("ui_right"):
		$Marker2D.position.x = 17
	if Input.is_action_pressed("ui_left"):
		$Marker2D.position.x = -17
	
	if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
		walking = true
	else:
		walking = false
	
	if not is_on_floor():
		$Character.play("Windy Idle")
		velocity.y += gravity * delta
		if velocity.y >= maxfallspeed:
			velocity.y = maxfallspeed
	
	if Global.stamina > 100.0:
		Global.stamina = 100.0
	if Global.stamina < 0:
		Global.stamina = 0
	
	if velocity.y == 0 and sprint == false:
		Global.stamina += 0.5
	
	if $Character/Wings.animation == "Closed" and $Character.animation == "Idle":
		$Character/Wings.scale.x = 1.25
		$Character/Wings.scale.y = 0.9
		$Character/Wings.position = Vector2(35, 12)
		$Character/Wings.rotation = 0
		$Character/Wings.z_index = -1
	elif $Character/Wings.animation == "Flap" and $Character.animation == "Windy Idle":
		$Character/Wings.scale.x = -1
		$Character/Wings.scale.y = 1
		$Character/Wings.position = Vector2(-39, -5)
		$Character/Wings.rotation = 0
		$Character/Wings.z_index = -1
	elif $Character/Wings.animation == "Glide" and $Character.animation == "Windy Idle":################:
		$Character/Wings.scale.x = 1
		$Character/Wings.scale.y = 1
		$Character/Wings.position = Vector2(21, -20)
		$Character/Wings.rotation = 0
		$Character/Wings.z_index = 1
	elif $Character/Wings.animation == "Closed" and $Character.animation == "Walk":
		$Character/Wings.scale.x = 1.25
		$Character/Wings.scale.y = 0.9
		$Character/Wings.position = Vector2(38, 12)
		$Character/Wings.rotation = 0.05
		$Character/Wings.z_index = -1
	elif $Character/Wings.animation == "Closed_Running" and $Character.animation == "Sprint":
		$Character/Wings.scale.x = 1.25
		$Character/Wings.scale.y = 0.9
		$Character/Wings.position = Vector2(21.5, 32)
		$Character/Wings.rotation = 0.9
		$Character/Wings.z_index = -1
	
	
	if velocity.x == 0 and is_on_floor():
		$Character.play("Idle")
	elif sprint == true and speed > 400 and is_on_floor():
		$Character.play("Sprint")
		$Character/Wings.scale.x = 1.25
		$Character/Wings.scale.y = 0.9
		$Character/Wings.position = Vector2(22.5, 30)
		$Character/Wings.rotation = 0.9
		$Character/Wings.play("Closed_Running") #Sprint anim
	elif sprint == false and is_on_floor():
		$Character.play("Walk")
		
	
	if velocity.y == 0 and sprint == false:
		$Character/Wings.play("Closed")


	
	if Input.is_action_pressed("ui_sprint") and is_on_floor() and Global.stamina > 0 and walking == true:
		accel = 2000
		speed = 600
		Global.stamina -= 0.25
		
		sprint = true
	else:
		accel = 1500
		speed = 400
		sprint = false
	
	input = get_input()
	
	if input == Vector2.ZERO:
		if velocity.length() > (friction * delta):
			velocity -= velocity.normalized() * (friction * delta)
		else:
			velocity = Vector2.ZERO
	else:
		velocity += (input * accel * delta)
		velocity = velocity.limit_length(speed)
	
	if Input.is_action_pressed("ui_fly") and Global.stamina > 0:
		velocity.y = flyspeed
		$Character/Wings.scale.x = -1
		$Character/Wings.play("Flap")
		$Character/Wings.position = Vector2(-39, -5)
		Global.stamina -= 1
	elif not is_on_floor() and Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right") and velocity.y < 0:
		$Character/Wings.play("Glide")
		$Character/Wings.position = Vector2(21, -20)
		
	if Input.is_action_pressed("ui_right"):
		$Character.scale.x = 1
	elif Input.is_action_pressed("ui_left"):
		$Character.scale.x = -1
	
	
	move_and_slide()

func inventory(delta):
	
	
	
	
	
	pass


func magic():
	if Global.spell == "Fireball": #AND FIRE SPELL
		var shoot = fireball.instantiate()
		get_parent().add_child(shoot)
		
		shoot.position = $Marker2D.global_position
		
		print(shoot)
		
		
	pass



func _physics_process(delta):
	
	player_movement(delta)
	inventory(delta)
	
	if cooldown > 0:
		cooldown -= 1
	
	if Input.is_action_just_pressed("click") and Global.melee == true and cooldown <= 0 and Global.cantattack == false:
		magic()
		cooldown += 20
	
	if Input.is_action_just_pressed("ui_switch"):
		Global.melee = !(Global.melee)
	
	#print($Character/Wings.position)
	
	
	pass


func _on_fire_spell_pickup():
	
	pickupfirespell.emit()
	
	pass # Replace with function body.


func _on_pick_up_radius_body_entered(body):
	
	if body.is_in_group("Item") and len(Global.inventory) != 0:
		body.queue_free()
		if body.is_in_group("FireSpell"):
			pickupfirespell.emit()
	
	pass # Replace with function body.
