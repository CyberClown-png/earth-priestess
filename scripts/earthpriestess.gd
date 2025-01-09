extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var direction = Vector2.ZERO
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var nextMove
@onready var ground_meele_A2D: Area2D = $"areas to read/ground meele"
@onready var ground_mid_far_A2D: Area2D = $"areas to read/ground mid-far"
@onready var air_close_A2D: Area2D = $"areas to read/air close"
@onready var air_mid_far_A2D: Area2D = $"areas to read/air mid far"

var attack_coldown = 1
var cast_speed = 1

func _ready() -> void:
	animated_sprite_2d.play("idle")

func _physics_process(delta: float) -> void:
	pass


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
