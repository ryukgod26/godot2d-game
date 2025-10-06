extends Node

@onready var pause_menu: Control = $"../Player/PauseMenu"
var paused = false
var score:int = 0
@onready var coinslbl: Label = $"../Player/Coins"


	
func add_point():
	score += 1
	coinslbl.text = "Score: " + str(score)





func _on_level_end_body_entered(body: Node2D) -> void:
	get_tree().change_scene_to_file("res://Scenes/level_selector.tscn")
