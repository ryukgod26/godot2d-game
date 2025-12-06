extends Enemy

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	move_to_player(delta)

func _on_detection_area_body_entered(body: Node2D) -> void:
	if not player:
		if body.is_in_group('Player'):
			player = body
			if not in_attack_range: 
				$AnimatedSprite2D.play("Spawn")
				spawned = true




func _on_attack_area_body_entered(body: Node2D) -> void:
	if body.is_in_group('Player'):
		in_attack_range = true


func _on_attack_area_body_exited(body: Node2D) -> void:
	if body.is_in_group('Player'):
		in_attack_range = false


func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite.animation == "Hit":
		is_hitting = false
