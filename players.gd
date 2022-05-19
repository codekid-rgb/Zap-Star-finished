extends KinematicBody2D

export (int) var speed = 200

var velocity = Vector2()

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	velocity = velocity.normalized() * speed

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)
	if globals.life <= 0:
		get_tree().change_scene("res://game over.tscn")
	if globals.pd == 0:
			queue_free()
			globals.life - 1
			get_tree().change_scene("res://worlds/world 1s.tscn")


func _on_enemy_area_entered(area):
	$boom.visible == true
	$boomt.start()
	queue_free()



func _on_boomt_timeout():
	$boom.visible == false
