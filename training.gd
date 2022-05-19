extends Node2D



func _on_Button_pressed():
	get_tree().change_scene("res://menu/start menu.tscn")




func _on_Player_fell():
	$Player.reset_player($spawn.position)
