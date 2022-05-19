extends Sprite
var i = null

func _physics_process(delta):

	var collision = get_slide_collision(i)
	var collider = collision.collider
	if collider.has_method("do_damage"):
		print("Collided with something that takes damage: ", collider.name)
		collider.do_damage(5)
