extends "res://scripts/Projectile.gd"

func _on_area_2d_body_entered(body: Node2D) -> void:
	super._on_area_2d_body_entered(body)
	if body.is_in_group("Player"):
		queue_free()
	
