extends Node2D



enum GameState { Loading, Running, GameOver }
onready var State = GameState.Loading;
onready var enemyObj = preload("res://Enemy.tscn")
var Player = null
var cam = null

func _ready():
	


# Called every frame. 'delta' is the elapsed time since the previous frame.





	State = GameState.Running
	
func _on_Area2D_area_entered(area):
	#Did we hit the trigger to queue boss fight?
	if(area.get_collision_layer_bit(4)):
		if(State == GameState.Running):
			Player.speed = 0
			globals.currentStage = globals.currentStage + 1
			get_tree().reload_current_scene()
		
	
func _on_GroundArea_area_entered(area):
	if(State == GameState.Running):
		Player.explode()
	
func PlayerDied():
	for i in Player.get_children():
		i.queue_free()
	remove_child(Player)
	globals.life - 1


