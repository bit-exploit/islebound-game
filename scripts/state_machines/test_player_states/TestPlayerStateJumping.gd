class_name TestPlayerStateJumping extends StateBase

func start() -> void:
	print("[+] jumping")
	controlled_node.animation_player.play("captain_jumping") # iniciar animación


func end() -> void:
	print("[-] jumping")


func on_physics_process(delta: float) -> void:
	# físicas
	controlled_node.apply_gravity(delta)
	controlled_node.handle_movement(delta)
	controlled_node.move_and_slide()


func on_process(_delta: float) -> void:
	if controlled_node.velocity.y > 0:
		state_machine.change_to("test_player_state_falling") # cambiar a estado de caer

	elif controlled_node.is_on_floor():
		if controlled_node.velocity.x == 0: state_machine.change_to("test_player_state_idle") # cambiar a estado inactivo
		else: state_machine.change_to("test_player_state_running") # cambiar a estado de correr


func on_input(_event: InputEvent) -> void:
	if Input.is_action_just_released("ui_accept"):
		controlled_node.handle_jump(true) # cortar salto con el parámetro cut=true

	elif Input.is_action_just_pressed("ui_attack"):
		state_machine.change_to("test_player_state_airattack") # cambiar al estado de atacar pero en el aire
