class_name VoidArea extends Node

func _on_body_entered(body: Node2D) -> void:
	if body is TestPlayer:
		body.global_position = Vector2.ZERO
