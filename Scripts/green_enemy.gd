extends Node2D

var SPEED = 60
var direction = 1
var health := 2

@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var game_manager: Node = %GameManager


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func check_death():
	if health <=0:
		game_manager.add_point()
		animated_sprite.play("death")
		animation_player.play("death")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if ray_cast_right.is_colliding():
		direction = -1
		animated_sprite.flip_h = true
	
	if ray_cast_left.is_colliding():
		direction = 1
		animated_sprite.flip_h = false
	position.x += SPEED * delta * direction
	
	


func _on_jump_damage_body_entered(body: Node2D) -> void:
	animated_sprite.animation = 'damage'
	print(body.name)
	print('Enemy Got Damaged')
	health -= 1
	check_death()
	
	

func _on_animated_sprite_2d_animation_finished() -> void:
	if(animated_sprite.animation == 'damage'):
		animated_sprite.play("Idle")
