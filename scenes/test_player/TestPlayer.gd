class_name TestPlayer extends CharacterBody2D

@export var speed: float = 160.0
@export var acceleration: float = 600.0
@export var friction: float = 600.0
@export var jump_force: float = -360.0
@export var gravity: float = 980.0
@export var max_fall_speed: float = 500.0
@export var jump_cut_multiplier: float = 0.5
@export var coyote_time_duration: float = 0.15

var coyote_time: float = 0.0

func apply_gravity(delta: float) -> void:
	velocity.y += gravity * delta
	velocity.y = min(velocity.y, max_fall_speed)

func handle_movement(delta: float) -> void:
	var direction: float = Input.get_axis("ui_left", "ui_right")

	if direction != 0:
		velocity.x = move_toward(velocity.x, direction * speed, acceleration * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, friction * delta)

func handle_jump(cut: bool = false) -> void:
	if not cut:
		velocity.y = jump_force
	else:
		velocity.y *= jump_cut_multiplier
		
func update_coyote_time(delta: float) -> void:
	coyote_time = max(coyote_time - delta, 0.0)
func reset_coyote_time() -> void:
	coyote_time = coyote_time_duration
