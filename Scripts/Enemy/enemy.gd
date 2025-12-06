class_name Enemy
extends CharacterBody2D

var player
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
var detection_radius := 200.0
var SPEED = 100
var health = 10
var is_hitting: bool = false
var in_attack_range: bool = false
const DAMAGE = 20
var spawned: bool = false

func _ready() -> void:
	#player = get_tree().get_first_node_in_group('Player')
	add_to_group("Enemy")

func move_to_player(_delta):
	if not player:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		move_and_slide()
		return
		
	if is_hitting:
		velocity.x = 0
		move_and_slide()
		return
	if not spawned:
		return

	var distance_to_player = global_position.distance_to(player.global_position)
	var direction = (player.global_position - global_position).normalized()
	print(direction)
	if direction.x < 0:
		animated_sprite.flip_h = false
		if has_node("AttackArea/AttackCollision"):
			$AttackArea/AttackCollision.position.x = -50
	elif direction.x > 0:
		animated_sprite.flip_h = true 
		if has_node("AttackArea/AttackCollision"):
			$AttackArea/AttackCollision.position.x = 50

	if in_attack_range: 
		velocity.x = 0
		attack_logic()
	else:
		velocity.x = direction.x * SPEED
		if animated_sprite.animation != "Run":
			animated_sprite.play("Run")
	#else:
		#velocity.x = 0
		#if animated_sprite.animation != "Idle":
			#animated_sprite.play("Idle")
			
	move_and_slide()

func take_damage(amount: int):
	health -= amount
	is_hitting = true
	print("Damage Test")
	if health <= 0:
		animated_sprite.play('Death')
		queue_free()
	else:
		animated_sprite.play("Hit")

func attack_logic():
	if not $Timers/AttackTimer.is_stopped():
		return
		
	animated_sprite.play("Attack")
	velocity.x = 0
	$Timers/AttackTimer.start()
	
	if player and player.has_method("take_damage"):
		player.take_damage(DAMAGE)


func _on_attack_timer_timeout() -> void:
	pass
