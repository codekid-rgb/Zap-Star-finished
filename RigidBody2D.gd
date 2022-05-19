extends RigidBody2D

func _physics_process(delta):
	if globals.zl == 0:
		$c.disabled = true
		$v.visible = false
