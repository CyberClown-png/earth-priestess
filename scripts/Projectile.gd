extends RigidBody2D

@export var affected_by_gravity: bool = true
@export var _gravity_scale: float = 1
@export var lifetime: float = 3.0

func _ready():
	if affected_by_gravity:
		gravity_scale = _gravity_scale
	else:
		gravity_scale = 0

	await get_tree().create_timer(lifetime).timeout
	queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		if body.has_method("get_dmg"):
			body.get_dmg()
		else: 
			print("body " + body.name + " dont have a get_dmg method")
	if body.is_in_group("ColideableEnvironment"):
		queue_free()
	
