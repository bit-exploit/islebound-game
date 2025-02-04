class_name TestPlayerStateAirAttack extends StateBase

func start() -> void:
	print("[+] airattack")
	controlled_node.animation_player.play("captain_airattack") # iniciar animación


func end() -> void:
	print("[-] airattack")


func on_physics_process(delta: float) -> void:
	# físicas
	controlled_node.apply_gravity(delta)
	controlled_node.handle_movement(delta)
	controlled_node.move_and_slide()


func on_process(_delta: float) -> void:
	if controlled_node.is_on_floor():
		state_machine.change_to("test_player_state_attack") # cambiar a estado de atacar


func on_input(_event: InputEvent) -> void:
	if Input.is_action_just_released("ui_attack"):
		if controlled_node.velocity.y < 0:
			state_machine.change_to("test_player_state_jumping") # cambiar a estado de salto
		else:
			state_machine.change_to("test_player_state_falling") # cambiar a estado de caer
