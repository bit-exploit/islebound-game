class_name TestPlaterStateRunning extends StateBase

func start() -> void:
	print("[+] running")
	controlled_node.animation_player.play("captain_running")
	controlled_node.reset_coyote_time()
	
func end() -> void:
	print("[-] running")
	
func on_physics_process(delta: float) -> void:
	controlled_node.apply_gravity(delta) # gravity
	controlled_node.handle_movement(delta) # movement
	controlled_node.move_and_slide()
	 
func on_process(delta: float) -> void:
	if not controlled_node.is_on_floor():
		controlled_node.update_coyote_time(delta)
		if controlled_node.coyote_time == 0:
			state_machine.change_to("test_player_state_falling")
	elif controlled_node.coyote_time != controlled_node.coyote_time_duration:
		controlled_node.reset_coyote_time()
		
	if controlled_node.velocity.x == 0 and (not Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right")):
		state_machine.change_to("test_player_state_idle")
	
func on_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		state_machine.change_to("test_player_state_jumping")
	
