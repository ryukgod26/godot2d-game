extends CanvasLayer


func _ready() -> void:
	visible = false
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("Pause"):
		visible = not visible
		get_tree().paused = not get_tree().paused
	if visible: 
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _on_resume_pressed() -> void:
	get_tree().paused = false
	visible = false
	
func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

func _on_options_pressed() -> void:
	$Settings.visible = true
