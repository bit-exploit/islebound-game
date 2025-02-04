class_name TestPlayerStateIdle extends StateBase

func start() -> void:
	print("[+] idle")
	
	controlled_node.animation_player.play("captain_idle") # iniciar animación
	controlled_node.reset_coyote_time() # restablecer coyote_time

	
func end() -> void:
	print("[-] idle")


func on_physics_process(delta: float):
	controlled_node.move_and_slide()


func on_process(delta: float) -> void:
	if not controlled_node.is_on_floor():
		if controlled_node.velocity.y < 0:
			state_machine.change_to("test_player_state_jumping") # cambiar a estado de salto
		else:
			state_machine.change_to("test_player_state_falling") # cambiar a estado de caer


func on_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		controlled_node.handle_jump() # activar salto
		
	elif Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
		state_machine.change_to("test_player_state_running") # cambiar a estado de correr

	elif Input.is_action_just_pressed("ui_attack"):
		state_machine.change_to("test_player_state_attack") # cambiar a estado de atacar
