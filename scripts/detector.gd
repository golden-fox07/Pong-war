extends Area2D

@export var is_left = false

signal ball_out(is_left)

func _on_body_entered(body: Node2D) -> void:
	if body is Ball:
		ball_out.emit(is_left)
		
		
		
		
