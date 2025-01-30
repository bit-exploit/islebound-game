class_name TestPlayerStateJumping extends StateBase

func start() -> void:
	print("[+] jumping")
	controlled_node.animation_player.play("captain_jumping")
	controlled_node.handle_jump()
	
func end() -> void:
	print("[-] jumping")
	
func on_physics_process(delta: float) -> void:
	controlled_node.apply_gravity(delta) # gravity
	controlled_node.handle_movement(delta) # movement
	controlled_node.move_and_slide()

func on_process(_delta: float) -> void:
	if controlled_node.velocity.y > 0:
		state_machine.change_to("test_player_state_falling")

func on_input(_event: InputEvent) -> void:
	if Input.is_action_just_released("ui_accept"):
		controlled_node.handle_jump(true)
