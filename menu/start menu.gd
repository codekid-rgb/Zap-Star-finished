
extends Control



func _on_start_pressed():
	get_tree().change_scene("res://beginning.tscn")
	
	
	


func _on_quit_pressed():
	get_tree().quit()


func _on_start2_pressed():
	get_tree().change_scene("res://training.tscn")
	#hi!
