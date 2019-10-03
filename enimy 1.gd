extends KinematicBody2D
export var graviti = 28 

export var ground_speed= 100
const UP = Vector2(0, -1)
var motion = Vector2()
var walking_diretion = 1

func flip_diretion():
	walking_diretion *= -1
	$sensor.position.x *= -1

func _physics_process(delta):
	motion.y += graviti
	if is_on_floor():
		motion.x = lerp(motion.x, walking_diretion * ground_speed, 0.5)
		
		
	motion = move_and_slide(motion, UP)

	if is_on_wall() || $sensor.is_colliding() == false:
		flip_diretion()






