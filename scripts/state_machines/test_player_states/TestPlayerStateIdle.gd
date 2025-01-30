class_name TestPlayerStateIdle  extends StateBase

func start() -> void:
	print("[+] idle")
	controlled_node.reset_coyote_time()
func end() -> void:
	print("[-] idle")

func on_process(delta: float):
	if not controlled_node.is_on_floor():
		state_machine.change_to("test_player_state_falling")
	if controlled_node.velocity.x != 0 or Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
		state_machine.change_to("test_player_state_running")
	
func on_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		state_machine.change_to("test_player_state_jumping")
		
