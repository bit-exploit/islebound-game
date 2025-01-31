class_name SmoothCamera extends Camera2D

@export var target: NodePath
@export var smooth_speed: float = 0.1
@export var zoom_level: Vector2 = Vector2(1, 1)
@export var velocity_influence: float = 0.2
@export var min_velocity_threshold: float = 5.0

var target_node: Node2D = null
var velocity_smooth: Vector2 = Vector2.ZERO

func _ready() -> void:
	if target:
		target_node = get_node(target)
	else:
		push_warning("A lens has not been assigned for the camera.")
		
	zoom = zoom_level
	
	limit_top = -256
	limit_right = 512
	limit_bottom = 256
	limit_left = -512


func _process(delta: float) -> void:
	if target_node:
		var desired_position = target_node.position + offset
		
		if target_node is CharacterBody2D:
			velocity_smooth = velocity_smooth.lerp(target_node.velocity, delta * 10)
			
			if velocity_smooth.length() > min_velocity_threshold:
				desired_position += velocity_smooth * velocity_influence
			
		position = position.lerp(desired_position, smooth_speed)
