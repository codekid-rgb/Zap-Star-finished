extends Node2D




func _ready():
	$Player.reset_player($spawn.position)
	
func _on_Player_fell():
	$Player.reset_player($spawn.position)