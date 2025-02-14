class_name TestPlayerStateAttack extends StateBase

func start() -> void:
	print("[+] attack")
	
	controlled_node.animation_player.play("captain_attack") # iniciar animación
	controlled_node.reset_coyote_time() # restablecer coyote_time


func end() -> void:
	print("[-] attack")


func on_physics_process(delta: float) -> void:
	# físicas
	controlled_node.apply_gravity(delta)
	controlled_node.handle_movement(delta)
	controlled_node.move_and_slide()


func on_process(delta: float) -> void:
	_handle_coyote_time(delta)
	
	# if controlled_node.velocity.y != 0:
	# 	state_machine.change_to("test_player_state_airattack") # cambiar a estado de atacar pero en el aire


func on_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		controlled_node.handle_jump() # activar salto

	elif Input.is_action_just_released("ui_attack"):
		if controlled_node.velocity.x != 0:
			state_machine.change_to("test_player_state_running") # cambiar a estado de correr
		else:
			state_machine.change_to("test_player_state_idle") # cambiar a estado inactivo


func _handle_coyote_time(delta: float) -> void:
	if controlled_node.velocity.y != 0:
		controlled_node.update_coyote_time(delta)

		if controlled_node.coyote_time == 0:
			state_machine.change_to("test_player_state_airattack") # cambiar a estado de atacar en el aire
			
	elif controlled_node.coyote_time != controlled_node.coyote_time_duration:
		controlled_node.reset_coyote_time()
