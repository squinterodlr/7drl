class_name ActionManager extends RefCounted

var action_queue: Array[BaseAction]
var action_history: Array[BaseAction]
@export var history_length: int = 1024

func _init() -> void:
	action_queue = []

func queue_action(action: BaseAction) -> void:
	action_queue.push_front(action)
	
func add_to_history(action: BaseAction) -> void:
	if action_history.size() >= history_length:
		action_history.resize(history_length - 1)
	action_history.push_front(action)

func process_next() -> bool:
	if action_queue.is_empty():
		return true
	var action: BaseAction = action_queue.pop_back()
	add_to_history(action)
	return action.execute()
