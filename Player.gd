extends KinematicBody2D

signal fell
var did_fall = false


const UP = Vector2(0, -1)
const Gravity = 20
const acceleration = 50
const MAX_SPEED = 200
export var RESPAWN_HEIGHT = 1000
const jump_hight = -550
var motion = Vector2()

func reset_player(newPosition):
	did_fall = false
	position = newPosition

func _physics_process(delta):
	motion.y += Gravity
	var frction = false
	if Input.is_action_pressed("ui_right"):
		motion.x += acceleration
		motion.x = min(motion.x+acceleration, MAX_SPEED)
		$sprite.flip_h = false
		$sprite.play("run")
	elif Input.is_action_pressed("ui_left"):
		motion.x = max(motion.x -acceleration, -MAX_SPEED)
		$sprite.flip_h = true
		$sprite.play("run")
	else:
		$sprite.play("idle")
		frction = true
		
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			motion.y = jump_hight
		if frction == true:
			motion.x = lerp(motion.x, 0,0.5)
				
	else:
		if motion.y < 0:
			$sprite.play("jump")
		else:
			$sprite.play("fall")
		if frction == true:
			motion.x = lerp(motion.x, 0,0.05)
			
	motion=move_and_slide(motion,UP)
	
	if !did_fall && position.y > RESPAWN_HEIGHT:
		did_fall = true
		emit_signal("fell")