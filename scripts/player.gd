extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@export var speed = 200
@export var jump_force = -400  # Исправлен для более заметного прыжка
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var direction = Vector2.ZERO

func _ready() -> void:
	animated_sprite_2d.play("idle")

func _physics_process(delta: float) -> void:
	handle_input()
	determine_velocity(delta)
	determine_animation()
	move_and_slide()

func handle_input():
	# Управление горизонтальным движением
	direction.x = 0
	if Input.is_action_pressed("move Right"):
		direction.x = 1
	elif Input.is_action_pressed("move Left"):
		direction.x = -1

	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			direction.y = 1
		if Input.is_action_just_pressed("crouch"):
			direction.y = -1
	if Input.is_action_just_released("jump") || Input.is_action_just_released("crouch"):
		direction.y = 0

func determine_velocity(delta: float):
	# Обработка гравитации
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = 0  # Сброс вертикальной скорости при касании пола
	if is_on_floor() && direction.y == 1:
		velocity.y = jump_force

	velocity.x = speed * direction.x

func determine_animation():
	if direction.x > 0:
		animated_sprite_2d.flip_h = false
	elif direction.x < 0:
		animated_sprite_2d.flip_h = true


	if not is_on_floor():
		animated_sprite_2d.play("jump")
	elif direction.x != 0:
		animated_sprite_2d.play("run")
	elif direction.y == -1:
		animated_sprite_2d.play("crouch")
	else:
		animated_sprite_2d.play("idle")
