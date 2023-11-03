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
#UI
var stamina = 100


func get_input():
	input.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	return input.normalized()
func player_movement(delta):
		# Adds the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		if velocity.y >= maxfallspeed:
			velocity.y = maxfallspeed
	
	if stamina > 100.0:
		stamina = 100.0
	if stamina < 0:
		stamina = 0
	
	if velocity.y == 0 and sprint == false:
		stamina += 0.5
	
	
	
	if velocity.x == 0 and velocity.y == 0:
		$AnimatedSprite2D.play("Idle")
	elif sprint == true and speed > 400:
		$AnimatedSprite2D.play("Sprint") #Sprint anim
	elif sprint == false:
		$AnimatedSprite2D.play("Walk")
	
	
	
	if Input.is_action_pressed("ui_sprint") and is_on_floor() and stamina > 0:
		accel = 2000
		speed = 600
		stamina -= 0.25
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
	
	if Input.is_action_pressed("ui_fly") and stamina > 0:
		velocity.y = flyspeed
		stamina -= 0.3
	
	if Input.is_action_pressed("ui_right"):
		$AnimatedSprite2D.scale.x = 1
	elif Input.is_action_pressed("ui_left"):
		$AnimatedSprite2D.scale.x = -1
	
	
	move_and_slide()



func _physics_process(delta):
	
	player_movement(delta)
	
	
	
	
	
	pass
