extends CharacterBody3D


const THRUST_STRENGTH: float = 1.0
const PITCH_STRENGTH: float = 10.0
const ROLL_STRENGTH: float = 10.0

var pitch_velocity: float
var roll_velocity: float
var up_pressed: bool
var down_pressed: bool
var left_pressed: bool
var right_pressed: bool


func _ready() -> void:
	velocity = Vector3.ZERO
	pitch_velocity = 0
	roll_velocity = 0
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
	


func _process(delta: float) -> void:
	if left_pressed:	
		roll_velocity -= ROLL_STRENGTH * delta
	elif right_pressed:
		roll_velocity += ROLL_STRENGTH * delta
	global_rotate(transform.basis.z, roll_velocity * delta)
	
	if up_pressed:
		pitch_velocity += ROLL_STRENGTH * delta
	elif down_pressed:
		pitch_velocity -= ROLL_STRENGTH * delta
	global_rotate(transform.basis.x, pitch_velocity * delta)
	
	orthonormalize()
	
