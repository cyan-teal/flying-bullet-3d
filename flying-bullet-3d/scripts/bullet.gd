extends CharacterBody3D


const THRUST_STRENGTH: float = 10.0
const PITCH_STRENGTH: float = 10.0
const ROLL_STRENGTH: float = 10.0
const FORWARDS_DRAG_COEFFICIENT: float = 0.65
const PITCH_DRAG_COEFFICIENT: float = 0.65
const ROLL_DRAG_COEFFICIENT: float = 0.065
const INITIAL_FORWARDS_VELOCITY: float = 35.0
const BOUNCE_FORWARDS_VELOCITY_MULTIPLIER: float = 1.5

var forward_velocity: float
var pitch_velocity: float
var roll_velocity: float
var up_pressed: bool
var down_pressed: bool
var left_pressed: bool
var right_pressed: bool


func _ready() -> void:
	velocity = Vector3.ZERO
	forward_velocity = INITIAL_FORWARDS_VELOCITY
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
	var roll_drag: float = roll_velocity * roll_velocity * PITCH_DRAG_COEFFICIENT * delta
	if roll_velocity > 0:
		roll_drag *= -1
	roll_velocity += roll_drag
	global_rotate(transform.basis.z, roll_velocity * delta)
	
	if up_pressed:
		pitch_velocity += PITCH_STRENGTH * delta
	elif down_pressed:
		pitch_velocity -= PITCH_STRENGTH * delta
	var pitch_drag: float = pitch_velocity * pitch_velocity * PITCH_DRAG_COEFFICIENT * delta
	if pitch_velocity > 0:
		pitch_drag *= -1
	pitch_velocity += pitch_drag
	global_rotate(transform.basis.x, pitch_velocity * delta)
	
	orthonormalize()
	
	forward_velocity += THRUST_STRENGTH * delta
	var forward_velocity_drag: float = forward_velocity * forward_velocity * FORWARDS_DRAG_COEFFICIENT * delta
	if forward_velocity > 0:
		forward_velocity_drag *= -1
	forward_velocity += forward_velocity_drag
	
	velocity = basis.z * forward_velocity * delta
	
	var collision = move_and_collide(velocity)
	if collision != null:
		bounce(collision)
	


func bounce(collision: KinematicCollision3D) -> void:
	var collision_normal = collision.get_normal()
	#var collision_collider_rid = collision.get_collider_rid()
	#var pre_bounce_velocity = velocity
	
	
	velocity = velocity.bounce(collision_normal) * BOUNCE_FORWARDS_VELOCITY_MULTIPLIER
	rotation = velocity.normalized()
	#rotation = velocity.angle()
	
	#position = collision.get_position() + pre_bounce_velocity
	#var stuck = true
	#while(stuck):
		##position += Vector2.from_angle(rotation)
		#var stuck_collision = move_and_collide(Vector3.ZERO, true)
		#if stuck_collision == null:
			##position += Vector2.from_angle(rotation)
			#stuck = false
		#elif stuck_collision.get_collider_rid() != collision_collider_rid:
			#bounce(stuck_collision)
			#stuck = false
	
