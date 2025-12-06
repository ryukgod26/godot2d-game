extends CharacterBody2D

@export var snow_sound: AudioStream
@onready var audio_stream_player: AudioStreamPlayer2D = $AudioStreamPlayer2D
const attacks = ["Attack1", "Attack2", "Attack3"]
const SPEED = 150.0
const JUMP_VELOCITY = -300.0
var is_hit := false
var health := 100
@onready var player: CharacterBody2D = $"."
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var death_timer: Timer = $Timers/DeathTimer
@onready var ui: Control = $UI
@onready var attack_collision: CollisionShape2D = $AttackArea/AttackCollision

var is_attacking:bool
var is_defending:bool
var current_action := "" 
@onready var tilemap_layers: Node2D = %TilemapLayers
var enemies = []
const DAMAGE = 2
var alive = true

func _ready() -> void:
	# Connect to all damage zones in the scene
	for zone in get_tree().get_nodes_in_group("damage_zones"):
		zone.damage_player.connect(_on_damage_received)

func _on_damage_received(amount: int) -> void:
	health -= amount

func _physics_process(delta: float) -> void:
	if not alive:
		return
	if is_hit:
		velocity.x = 0
		move_and_slide()
		return
	play_footstop_sound()
	move_logic(delta)
	attack_logic()
	move_and_slide()

func check_death() -> void:
	if health <=0:

		#$CollisionShape2D.queue_free()
		Engine.time_scale = 0.5
		ui.update_health(0)
		alive = false
		animated_sprite.play("Death")
		death_timer.start()
	else:
		ui.update_health(health)

func take_damage(damage:int):
	health -= damage
	check_death()
	is_hit = true
	animated_sprite.play("Hit")

func _on_timer_timeout() -> void:
	Engine.time_scale =1.0
	get_tree().reload_current_scene()
   
func _on_animated_sprite_2d_animation_finished() -> void:
	if(animated_sprite.animation == 'Hit'):
		is_hit = false
	if(animated_sprite.animation == 'Attack1' or animated_sprite.animation == 'Attack2' or animated_sprite.animation == 'Attack3'  ):
		is_attacking = false
	if (animated_sprite.animation == 'Defend'):
		is_defending = false
	current_action = ''

func move_logic(delta) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	if is_attacking:
		velocity.x = 0
		return
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		animated_sprite.animation = 'Jump'
		current_action = ""
			
	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("move_left", "move_right")
	#if is_attacking or is_defending or is_hit:
		#return
	#Flipping The Sprite BAsed on the Direction
	if(direction < 0):
		animated_sprite.flip_h = true
		attack_collision.position.x = -19
		animated_sprite.play("Run")
	elif (direction > 0):
		animated_sprite.flip_h = false
		attack_collision.position.x = 19
		animated_sprite.play("Run")
	else:
		animated_sprite.play("Idle")
		
	if direction:
		velocity.x = direction * SPEED
		
	else:
		velocity.x = 0#move_toward(velocity.x, 0, SPEED)

func play_footstop_sound() -> void:
	if not tilemap_layers or audio_stream_player.playing:
		return
	for tilemap_layer in tilemap_layers.get_children():
		var local_pos = tilemap_layer.to_local(global_position + Vector2(0, 10))
		var map_pos = tilemap_layer.local_to_map(local_pos)
		var tile_data = tilemap_layer.get_cell_tile_data(map_pos)
		#print(map_pos)
		if tile_data:
			#print("Played")
			var surface_type = tile_data.get_custom_data("Surface")
			if surface_type == 'Snow':
				print("Played play")
				audio_stream_player.stream = snow_sound
				audio_stream_player.play()

func attack_logic():
	if Input.is_action_just_pressed("Attack") and not is_attacking:
		var attack = attacks.pick_random()
		animated_sprite.play(attack)
		is_attacking = true
		for enemy in enemies:
			enemy.take_damage(DAMAGE)


func _on_attack_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		enemies.append(body)
		#print("Added Enemy",body)


func _on_attack_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		enemies.erase(body)
		#print("Removed Enemy",body)
