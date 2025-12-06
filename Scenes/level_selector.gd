extends Control



func _ready() -> void:
	pass # Replace with function body.


func _on_level_2_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/level_2.tscn")


func _on_level_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/game.tscn")


func _on_level_3_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/level_3.tscn")



func _on_winter_level_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/winter_level.tscn")
