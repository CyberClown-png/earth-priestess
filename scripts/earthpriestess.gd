extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var direction = Vector2.ZERO
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var ground_meele_A2D: Area2D = $"areas to read/ground meele"
@onready var ground_mid_far_A2D: Area2D = $"areas to read/ground mid-far"
@onready var air_close_A2D: Area2D = $"areas to read/air close"
@onready var air_mid_far_A2D: Area2D = $"areas to read/air mid far"

@export var max_attack_coldown = 2
var attack_coldown = 2


var last_triggered_area
var attack_system: attacks

func _ready() -> void:
	animated_sprite_2d.play("idle")
	attack_system = attacks.new()
	attack_coldown = max_attack_coldown


func _physics_process(delta: float) -> void:
	pass
	attack_coldown -= delta
	if attack_coldown <= 0:
		attack()
		print("attack happened")
		attack_coldown = max_attack_coldown


func _on_ground_meele_area_entered(area: Area2D) -> void:
	if area.name == "PlayerHurtBox":
		last_triggered_area = 1
		print("player on ground meele area")


func _on_ground_midfar_area_entered(area: Area2D) -> void:
	if area.name == "PlayerHurtBox":
		last_triggered_area = 2
		print("player on ground mid far area")


func _on_air_close_area_entered(area: Area2D) -> void:
	if area.name == "PlayerHurtBox":
		last_triggered_area = 3
		print("player on air close area")


func _on_air_mid_far_area_entered(area: Area2D) -> void:
	if area.name == "PlayerHurtBox":
		last_triggered_area = 4
		print("player on air mid far area")


func attack():
	
	#var boulder = attack_system.throw_boulder(self.position, Vector2(-1,-0.15))
	#get_parent().add_child(boulder)
	
	var earth_shards = attack_system.bestial_sling(self.position, Vector2(-1,-0.15))
	for shard in earth_shards:
		get_parent().add_child(shard)



class attacks:
	var boulder_projectile = preload("res://scenes/Boulder.tscn")
	var boulder_flight_speed = 800
	
	var earth_shard_projectile = preload("res://scenes/earth_shard.tscn")
	var shard_amount = 8
	var spread_angle = 60
	var shard_flight_speed = 800
	
	func throw_boulder(start_position: Vector2, direction: Vector2):
		var boulder = boulder_projectile.instantiate()
		boulder.position = start_position
		boulder.linear_velocity  = direction.normalized() * boulder_flight_speed
		return boulder
		
	func bestial_sling(start_position: Vector2, direction: Vector2):
		var arr = []
		var angle_step = spread_angle / shard_amount
		var half_angle = spread_angle / 2
	
		for shard in range(shard_amount):
			var final_angle = - half_angle + angle_step * shard
			var shard_instance = earth_shard_projectile.instantiate() as RigidBody2D
			shard_instance.position = start_position
			shard_instance.linear_velocity = direction.rotated(deg_to_rad(final_angle)).normalized() * shard_flight_speed
			
			arr.append(shard_instance)
		return arr
		
		
	func summon_wall():
		pass
	func primal_grasp():
		pass
