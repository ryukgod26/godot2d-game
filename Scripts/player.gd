extends CharacterBody2D

const SPEED = 150.0
const JUMP_VELOCITY = -300.0

var is_hit := false
var health := 100
var current_action := ""    # "hit", "attack", "defend", "" (idle/run/jump handled normally)
@onready var player: CharacterBody2D = $"." 
@onready var timer: Timer = $Timer
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var tile_map_layer: TileMapLayer = $"../TileMap/TileMapLayer"
@onready var healthlbl: Label = $health
var is_attacking: bool = false
var is_defending: bool = false

func _ready():
	for zone in get_tree().get_nodes_in_group("damage_zones"):
		zone.damage_player.connect(_on_damage_received)
	# connect the AnimatedSprite2D signal if not connected in the editor
	if not animated_sprite.is_connected("animation_finished", self, "_on_animated_sprite_2d_animation_finished"):
		animated_sprite.connect("animation_finished", self, "_on_animated_sprite_2d_animation_finished")

func _on_damage_received(amount: int):
	get_damage(amount)

func _physics_process(delta: float) -> void:
	# If hit, ignore input/animation changes and optionally zero horizontal movement
	if is_hit:
		velocity.x = 0
		move_and_slide()
		return

	# Add gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Jump input
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		animated_sprite.animation = "Jump"
		current_action = ""   # jump is not an interruptible action flag here

	# Attack input
	if Input.is_action_just_pressed("Attack") and is_on_floor():
		animated_sprite.play("Attack1")
		is_attacking = true
		current_action = "attack"

	# Defend input
	if Input.is_action_just_pressed("Defend") and is_on_floor():
		animated_sprite.play("Defend")
		is_defending = true
		current_action = "defend"

	# Movement input (only change run/idle when not attacking/defending)
	var direction := Input.get_axis("move_left", "move_right")
	if not is_attacking and not is_defending:
		if direction < 0:
			animated_sprite.flip_h = true
			if is_on_floor():
				animated_sprite.animation = "Run"
		elif direction > 0:
			animated_sprite.flip_h = false
			if is_on_floor():
				animated_sprite.animation = "Run"
		else:
			if is_on_floor():
				animated_sprite.animation = "Idle"

	# Apply horizontal velocity
	if direction != 0:
		velocity.x = direction * SPEED
	else:
		velocity.x = 0

	move_and_slide()

func check_death():
	if health <= 0:
		timer.start()
		player.get_node("CollisionShape2D").queue_free()
		Engine.time_scale = 0.5
		print("You Died")

func get_damage(damage: int):
	health -= damage
	healthlbl.text = "Health: " + str(health)
	print("Player Hp is: " + str(health))
	check_death()
	is_hit = true
	current_action = "hit"
	animated_sprite.play("Hit")

func _on_timer_timeout() -> void:
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()

func _on_animated_sprite_2d_animation_finished() -> void:
	# Use current_action to know which flag to clear reliably
	if current_action == "hit":
		is_hit = false
	elif current_action == "attack":
		is_attacking = false
	elif current_action == "defend":
		is_defending = false
	current_action = ""
