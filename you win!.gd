extends Node2D


func _on_Button_pressed():
	get_tree().change_scene("res://menu/start menu.tscn")
func _on_Button2_pressed():
	get_tree().change_scene("res://credits.tscn")
