class_name StateBase extends Node
 
@onready var controlled_node: Node = self.owner

var state_machine: StateMachine

func start() -> void:
	pass

func end() -> void:
	pass
