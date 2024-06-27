extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
const maxfallspeed = 1000

var cantbepickedup = 25

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if cantbepickedup > 0:
		cantbepickedup -= 1
	
	if not is_on_floor():
		velocity.y += gravity * delta
		if velocity.y >= maxfallspeed:
			velocity.y = maxfallspeed
	
	move_and_slide()
	
	pass





