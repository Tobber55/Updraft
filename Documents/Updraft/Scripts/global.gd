extends Node

# UI
var stamina = 100
var health = 100
var xp = 0

var time = 0

# Attack
var melee = false
var spell = "Fireball"

var inventory = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	_time()
	
	
	
	pass
	
	
func _time():
	while true:
		await get_tree().create_timer(1).timeout
		time += 0.01
		#print(time)
	
	if fmod((time*10), 10) == 6:
		time += 0.4
