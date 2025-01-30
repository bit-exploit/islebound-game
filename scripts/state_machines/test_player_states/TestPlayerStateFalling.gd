class_name TestPlayerStateFalling extends StateBase

func start() -> void:
	print("[+] falling")
func end() -> void:
	print("[-] falling")
	
func on_physics_process(delta: float):
	controlled_node.apply_gravity(delta) # gravity
	controlled_node.handle_movement(delta) # movement
	controlled_node.move_and_slide()
	
func on_process(delta: float):
	if controlled_node.is_on_floor():
		if controlled_node.velocity.x == 0: state_machine.change_to("test_player_state_idle")
		else: state_machine.change_to("test_player_state_running")
