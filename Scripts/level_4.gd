extends Node2D

@onready var pause_menu: Control = $Player/PauseMenu
var paused = false

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



func _on_pause_menu_resumed() -> void:
	pauseMenu()
