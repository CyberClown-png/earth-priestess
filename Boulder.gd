extends StaticBody2D

@export var speed: float = 400
var direction: Vector2 = Vector2.ZERO

func _ready():
	await get_tree().create_timer(5.0).timeout
	queue_free()

func _process(delta: float) -> void:
	position += direction * speed * delta
