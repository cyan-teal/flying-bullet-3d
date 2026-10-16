extends CharacterBody3D


var current_turn_direction: Direction
var turn_inputs_stack: Array[Direction]


enum Direction {
	NEUTRAL = 0,
	UP = 1,
	DOWN = 2,
	LEFT = 3, 
	RIGHT = 4,
}


func _ready() -> void:
	current_turn_direction = Direction.NEUTRAL
	turn_inputs_stack.clear()
	turn_inputs_stack.push_front(Direction.NEUTRAL)


func _unhandled_key_input(event: InputEvent) -> void:
	var event_is_pressed_kind: bool = false
	if event.is_pressed():
		event_is_pressed_kind = true
	
	var event_direction: Direction
	if event.is_action("turn_up"):
		event_direction  = Direction.UP
	elif event.is_action("turn_down"):
		event_direction  = Direction.DOWN
	elif event.is_action("turn_left"):
		event_direction  = Direction.LEFT
	elif event.is_action("turn_right"):
		event_direction  = Direction.RIGHT
	else:
		return
	
	if event_direction == turn_inputs_stack.back() and event_is_pressed_kind:
		return
	
	if event_is_pressed_kind:
		turn_inputs_stack.push_back(event_direction)
	else:
		turn_inputs_stack.erase(event_direction)
	current_turn_direction = turn_inputs_stack.back()
	
