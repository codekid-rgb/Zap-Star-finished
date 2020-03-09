extends KinematicBody2D
signal spawn_bullet(direction,gloabal_postion)

signal fell
var did_fall = false

const UP = Vector2(0, -1)
const Gravity = 20
const acceleration = 50
const MAX_SPEED = 500
export var RESPAWN_HEIGHT = 1000
const jump_hight = -650
var motion = Vector2()
var invulnerable_time = 0
var reload_time = 0
var helth = 20
var direction = 0
export(String, FILE, "*.tscn") var world_scene

func ones_place(x):
	return x % 10

func tens_place(x):
	return (x/10) % 10
	
func digit_to_region(digit):
	match digit:
		0: return Rect2(82+16,226+16+16,16,16)
		1: return Rect2(82,226,16,16)
		2: return Rect2(82+16,226,16,16)
		3: return Rect2(82+16+16,226,16,16)
		4: return Rect2(82+16+16+16,226,16,16)
		5: return Rect2(82,226+16,16,16)
		6: return Rect2(82+16,226+16,16,16)
		7: return Rect2(82+16+16,226+16,16,16)
		8: return Rect2(82+16+16+16,226+16,16,16)
		9: return Rect2(82,226+16+16,16,16)
	return Rect2(59,232,16,16)

func reset_player(newPosition):
	did_fall = false
	invulnerable_time = 0
	position = newPosition

func reset_player_and_warp():
	helth = 20
	did_fall = true
	emit_signal("fell")
	

func do_damage(damage):
	if invulnerable_time <= 0:
		print("Damage: ", damage, ", Health: ", helth)
		invulnerable_time = 1
		helth -= damage
		if helth <= 0:
			reset_player_and_warp()

func _physics_process(delta):
	var tens_reg = digit_to_region(tens_place(helth))
	$"player_camera/tens place".texture.set_region(tens_reg)
	var ones_reg = digit_to_region(ones_place(helth))
	$"player_camera/ones place".texture.set_region(ones_reg)
	
	if reload_time > 0:
		reload_time -= delta
		

	motion.y += Gravity
	if invulnerable_time > 0:
		invulnerable_time -= delta
	var frction = false
	if Input.is_action_pressed("ui_right"):
		direction = +1
		motion.x += acceleration
		motion.x = min(motion.x+acceleration, MAX_SPEED)
		$sprite.flip_h = false
		$sprite.play("run")
	elif Input.is_action_pressed("ui_left"):
		direction = -1
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
	
	if Input.is_action_pressed("ui_select"):
		$sprite.play("shoot")
		if reload_time <= 0:
			reload_time = 0.25
			var pos
			if direction < 0:
				pos = $"gun spawn2".get_global_position()
			else:
				pos = $"gun spawn".get_global_position()
			emit_signal("spawn_bullet",direction,pos)
	
	motion = move_and_slide(motion, UP)


	if !did_fall && position.y > RESPAWN_HEIGHT:
		did_fall = true
		emit_signal("fell")

func _on_quit_pressed():
	get_tree().change_scene(world_scene)


