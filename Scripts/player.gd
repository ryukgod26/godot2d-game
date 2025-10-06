extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -300.0
var is_hit := false
var health := 100
@onready var player: CharacterBody2D = $"."
@onready var timer: Timer = $Timer
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var tile_map_layer: TileMapLayer = $"../TileMap/TileMapLayer"
@onready var healthlbl: Label = $health
var is_attacking:bool
var is_defending:bool
var current_action := "" 
	
func _ready():
	# Connect to all damage zones in the scene
	for zone in get_tree().get_nodes_in_group("damage_zones"):
		zone.damage_player.connect(_on_damage_received)

func _on_damage_received(amount: int):
	health -= amount
	print("Ouch! Health now:", health)

func _physics_process(delta: float) -> void:
	if is_hit:
		velocity.x = 0
		move_and_slide()
		return

	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		animated_sprite.animation = 'Jump'
		current_action = ""

	if Input.is_action_just_pressed("Attack") and is_on_floor():
		animated_sprite.animation = 'Attack1'
		is_attacking =true
		current_action = 'attack'
		
	if Input.is_action_just_pressed("Defend") and is_on_floor():
		animated_sprite.animation = 'Defend'
		is_defending = true
		current_action = 'defend'
			
	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("move_left", "move_right")
	#if is_attacking or is_defending or is_hit:
		#return
	#Flipping The Sprite BAsed on the Direction
	if(direction < 0):
		animated_sprite.flip_h = true
		animated_sprite.animation = 'Run'
	elif (direction > 0):
		animated_sprite.flip_h = false
		animated_sprite.animation = 'Run'
	else:
		animated_sprite.animation = 'Idle'
		
	if direction:
		velocity.x = direction * SPEED
		
	else:
		velocity.x = 0#move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func check_death():
	if health <=0:
		timer.start()
		player.get_node('CollisionShape2D').queue_free()
		Engine.time_scale = 0.5
		print("You Died")
		
		

func get_damage(damage:int):
	
	health -= damage
	healthlbl.text = 'Health: ' + str(health)
	print('Player Hp is: ' + str(health))
	check_death()
	is_hit = true
	animated_sprite.play("Hit")

func _on_timer_timeout() -> void:
	Engine.time_scale =1.0
	get_tree().reload_current_scene() # Replace with function body.

		   
func _on_animated_sprite_2d_animation_finished() -> void:
	if(animated_sprite.animation == 'Hit'):
		is_hit = false
	if(animated_sprite.animation == 'Attack1'):
		is_attacking = false
	if (animated_sprite.animation == 'Defend'):
		is_defending = false
	current_action = ''
