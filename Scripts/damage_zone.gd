extends Area2D

signal damage_player(amount:int)

@export var  DAMAGE := 25
@onready var player: CharacterBody2D = $Player


func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))


func _on_body_entered(body: Node2D) -> void:
	print('Damage')
	if 'get_damage' in body:
		body.get_damage(DAMAGE)
	
	
