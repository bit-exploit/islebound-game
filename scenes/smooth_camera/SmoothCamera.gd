class_name SmoothCamera extends Camera2D

@export_category("Script Settings")
@export_group("Camera Options")
@export var target: NodePath
@export var smooth_speed: float = 0.1
@export var zoom_level: Vector2 = Vector2(1, 1)
@export var velocity_influence: float = 0.15
@export var min_velocity_threshold: float = 10.0

@export_group("Camera Limits")
@export var set_limit_top: float = 0
@export var set_limit_right: float = 0
@export var set_limit_bottom: float = 0
@export var set_limit_left: float = 0

var target_node: Node2D = null
var velocity_smooth: Vector2 = Vector2.ZERO


func _ready() -> void:
	if target:
		target_node = get_node(target)
	else:
		push_warning("A lens has not been assigned for the camera.")
		
	zoom = zoom_level
	
	if set_limit_top != 0:
		limit_top = set_limit_top
	if set_limit_right != 0:
		limit_right = set_limit_right
	if set_limit_bottom != 0:
		limit_bottom = set_limit_bottom
	if set_limit_left != 0:
		limit_left = -512


func _process(delta: float) -> void:
	if target_node:
		var desired_position = target_node.position + offset
		
		if target_node is CharacterBody2D:
			velocity_smooth = velocity_smooth.lerp(target_node.velocity, delta * 10)
			
			if velocity_smooth.length() > min_velocity_threshold:
				desired_position += velocity_smooth * velocity_influence
			
		position = position.lerp(desired_position, smooth_speed)
