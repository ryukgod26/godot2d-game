extends Node2D

@onready var pause_menu: Control = $Player/PauseMenu
var paused = false
var score:int  = 0
@onready var coinslbl: Label = $Player/Coins

func pauseMenu():
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0
	paused = !paused

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Pause"):
		pauseMenu()
func add_point():
	score += 1
	coinslbl.text = "Score: " + str(score)


func _on_pause_menu_resumed() -> void:
	pauseMenu()
