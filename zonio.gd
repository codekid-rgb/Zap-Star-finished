extends KinematicBody2D
export var graviti = 28 
export var ground_speed= 100

const UP = Vector2(0, -1)

var motion = Vector2()
var walking_diretion = 1
var health = 10

func do_bullet_damage(dmg):
	health = health - dmg
	if health <= 0:
		globals.zl = 0
		queue_free()

func flip_diretion():
	walking_diretion *= -1
	$en_floor_sensor.position.x *= -1
	if walking_diretion == -1:
		$sprite.flip_h = true
	elif walking_diretion == 1:
		$sprite.flip_h = false
# warning-ignore:unused_argument
func _physics_process(delta):
	motion.y += graviti
	if is_on_floor():
		motion.x = lerp(motion.x, walking_diretion * ground_speed, 0.9)
	motion = move_and_slide(motion, UP)
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		var collider = collision.collider
		if collider.has_method("do_damage"):
			print("Collided with something that takes damage: ", collider.name)
			collider.do_damage(10)
	# If the agent is touching a wall or the sensor is not touching a floor (cliff) flip
	if is_on_wall() || $en_floor_sensor.is_colliding() == false:
		flip_diretion()
