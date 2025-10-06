extends Node

@onready var pause_menu: Control = $"../Player/PauseMenu"
var paused = false
var score:int = 0
@onready var coinslbl: Label = $"../Player/Coins"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Pause"):
		pauseMenu()
func pauseMenu():
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0
	paused = !paused
	
func add_point():
	score += 1
	coinslbl.text = "Score: " + str(score)





func _on_level_end_body_entered(body: Node2D) -> void:
	get_tree().change_scene_to_file("res://Scenes/level_selector.tscn")





func _on_pause_menu_resumed() -> void:
	pauseMenu()
