class_name TestPlayer extends CharacterBody2D

@export var speed: float = 180.0
@export var acceleration: float = 600.0
@export var friction: float = 600.0
@export var jump_force: float = -400.0
@export var gravity: float = 980.0
@export var max_fall_speed: float = 500.0
@export var jump_cut_multiplier: float = 0.65   
@export var coyote_time_duration: float = 0.1

@onready var animation_player: AnimationPlayer = $animation_player
@onready var sprite: Sprite2D = $sprite
var coyote_time: float = 0.

# private
func _change_sprite_direction(x: float) -> void:
	if (x < 0 and sprite.scale.x >= 0) or (x > 0 and sprite.scale.x <= 0):
		sprite.scale.x = sprite.scale.x * -1

# public
func apply_gravity(delta: float) -> void:
	velocity.y += gravity * delta
	velocity.y = min(velocity.y, max_fall_speed)

func handle_movement(delta: float) -> void:
	var direction: float = Input.get_axis("ui_left", "ui_right")

	if direction != 0:
		velocity.x = move_toward(velocity.x, direction * speed, acceleration * delta)
		_change_sprite_direction(direction)
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
