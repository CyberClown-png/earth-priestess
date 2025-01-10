extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var direction = Vector2.ZERO
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var nextMove
@onready var ground_meele_A2D: Area2D = $"areas to read/ground meele"
@onready var ground_mid_far_A2D: Area2D = $"areas to read/ground mid-far"
@onready var air_close_A2D: Area2D = $"areas to read/air close"
@onready var air_mid_far_A2D: Area2D = $"areas to read/air mid far"

@onready var wall_colision: CollisionShape2D = $AttackColisions/wall_colision

@export var TimeForAttack = 0.5 

@export var max_attack_coldown = 1
var attack_coldown = 1

var cast_speed = 1

@export var boulder_projectile = preload("res://scenes/Boulder.tscn")
@export var boulder_flight_speed = 200


func _ready() -> void:
	animated_sprite_2d.play("idle")

func _physics_process(delta: float) -> void:
	pass
	attack_coldown -= delta
	if attack_coldown <= 0:
		attack()
		print("attack happened")
		attack_coldown = max_attack_coldown


func _on_ground_meele_area_entered(area: Area2D) -> void:
	if area.name == "PlayerHurtBox":
		print("player on ground meele area")


func _on_ground_midfar_area_entered(area: Area2D) -> void:
	if area.name == "PlayerHurtBox":
		print("player on ground mid far area")


func _on_air_close_area_entered(area: Area2D) -> void:
	if area.name == "PlayerHurtBox":
		print("player on air close area")


func _on_air_mid_far_area_entered(area: Area2D) -> void:
	if area.name == "PlayerHurtBox":
		print("player on air mid far area")


func attack():
	throw_boulder()
	pass

func collisionAttackDrawRed(collision: CollisionShape2D):
	collision.modulate = Color.RED
	
	var timer = Timer.new()
	timer.wait_time = TimeForAttack
	timer.one_shot = true
	add_child(timer)
	timer.start()
	timer.connect("timeout", Callable(self, "_reset_collision_color").bind(collision))
	
func _reset_collision_color(collision: CollisionShape2D):
	if collision:  # Убедитесь, что объект ещё существует.
		collision.modulate = Color.WHITE  # Возвращаем исходный цвет.

func collisionAttackDrawblue(collision: CollisionShape2D):
	collision.modulate = Color.SKY_BLUE
	
	pass

func throw_boulder():
	var direction: Vector2 = Vector2.ZERO
	var projectile = boulder_projectile.instantiate()
	projectile.position = position
	var target_position = get_global_mouse_position()
	projectile.direction = (target_position - position).normalized()
	get_parent().add_child(projectile)
