extends Area2D

@export var  DAMAGE := 25
@onready var player: CharacterBody2D = $Player


func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))
 
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group('Player'):
		body.take_damage(DAMAGE)
