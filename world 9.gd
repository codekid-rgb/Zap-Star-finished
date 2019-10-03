extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.

 # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	passCalled when the node enters the scene tree for the first time.
func _ready():
	$Player.reset_player($spawn.position)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Player_fell():
	$Player.reset_player($spawn.position)
	




	pass # Replace with function body.
