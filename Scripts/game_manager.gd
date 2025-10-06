extends Node


var score:int = 0
@onready var coinslbl: Label = $"../Player/Coins"
var is_paused:bool= false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
func add_point():
	score += 1
	coinslbl.text = "Score: " + str(score)





func _on_level_end_body_entered(body: Node2D) -> void:
	get_tree().change_scene_to_file("res://Scenes/level_selector.tscn")


func _on_pause_pressed() -> void:
	print('Paused')
	is_paused = !is_paused
	get_tree().paused = is_paused
