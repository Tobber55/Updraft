extends Node2D

var velocity = Vector2(0, 0)
var speed = 10
var hittable = true
var timer = 250

# Called when the node enters the scene tree for the first time.
func _ready():
	$CPUParticles2D.gravity.y = 980
	#$CPUParticles2D.gravity.y = -1 * sin(self.global_position.angle_to(get_global_mouse_position())) * self.global_position.distance_to(get_global_mouse_position())
	print(asin(get_global_mouse_position().x / get_global_mouse_position().y))
	#print(sin(self.global_position.angle_to(get_global_mouse_position())))
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	timer -= 1
	if timer <= 0:
		$CPUParticles2D.emitting = false
		hittable = false #FOR WHEN MAKE CONTACT WITH ENEMY
		await get_tree().create_timer(0.4).timeout
		self.queue_free()
	
	velocity.normalized() * delta * speed
	
	
	pass
