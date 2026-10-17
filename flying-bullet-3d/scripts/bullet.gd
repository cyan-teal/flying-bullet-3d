extends CharacterBody3D



var rotational_velocity: Quaternion
var up_pressed: bool
var down_pressed: bool
var left_pressed: bool
var right_pressed: bool


func _ready() -> void:
	rotation = Vector3.UP
	rotational_velocity = Quaternion.IDENTITY
	up_pressed = false
	down_pressed = false
	left_pressed = false
	right_pressed = false


func _unhandled_key_input(event: InputEvent) -> void:
	var event_is_pressed_kind: bool = false
	if event.is_pressed():
		event_is_pressed_kind = true
	
	if event.is_action("turn_up"):
		up_pressed = event_is_pressed_kind
	elif event.is_action("turn_down"):
		down_pressed = event_is_pressed_kind
	elif event.is_action("turn_left"):
		left_pressed = event_is_pressed_kind
	elif event.is_action("turn_right"):
		right_pressed = event_is_pressed_kind
	else:
		return
	


func _process(_delta: float) -> void:
	pass
	
