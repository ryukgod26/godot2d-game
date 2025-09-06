extends Area2D

@onready var timer: Timer = $Timer

func _on_body_entered(body: Node2D) -> void:
	timer.start()
	body.get_node('CollisionShape2D').queue_free()
	Engine.time_scale = 0.5
	print("You Died")


func _on_timer_timeout() -> void:
	Engine.time_scale =1.0
	get_tree().reload_current_scene()
