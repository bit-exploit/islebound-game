class_name TestPlayerStateFalling extends StateBase

func start() -> void:
	print("[+] falling")
	controlled_node.animation_player.play("captain_falling")
	
func end() -> void:
	print("[-] falling")
	
func on_physics_process(delta: float) -> void:
	controlled_node.apply_gravity(delta) # gravity
	controlled_node.handle_movement(delta) # movement
	controlled_node.move_and_slide()
	
func on_process(delta: float) -> void:
	if controlled_node.is_on_floor():
		if controlled_node.velocity.x == 0: state_machine.change_to("test_player_state_idle")
		else: state_machine.change_to("test_player_state_running")
