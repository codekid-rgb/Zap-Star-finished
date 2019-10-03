
extends Control



func _on_start_pressed():
	get_tree().change_scene("res://World1.tscn")


func _on_quit_pressed():
	get_tree().quit()
