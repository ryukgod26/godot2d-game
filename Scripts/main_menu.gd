extends Control

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/level_selector.tscn")


func _on_settings_pressed() -> void:
	$Settings.visible = true

func _on_quit_pressed() -> void:
	get_tree().quit()
