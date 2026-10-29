extends Node3D


const THRUST_STRENGTH: float = 0.009
const LINEAR_DRAG_STRENGTH: float = 0.1
const ROTATIONAL_STRENGTH: float = 0.009
const ROTATIONAL_DRAG_STRENGTH: float = 0.1

var target_position: Vector3
var target_rotation: Vector3
var velocity: Vector3
var rotational_velocity: Vector3


func _ready() -> void:
	target_position = Vector3.ZERO
	target_rotation = Vector3.ZERO
	velocity = Vector3.ZERO
	rotational_velocity = Vector3.ZERO
	


func _physics_process(delta: float) -> void:
	const AXIES_IN_THREE_DIMENSIONS: int = 3
	for axis in AXIES_IN_THREE_DIMENSIONS:
		var self_axis_is_greater_than_target_axis: bool = self.position[axis] < target_position[axis]
		velocity[axis] += THRUST_STRENGTH if self_axis_is_greater_than_target_axis else -THRUST_STRENGTH
		velocity -= velocity * velocity * LINEAR_DRAG_STRENGTH * delta
		
	for axis in AXIES_IN_THREE_DIMENSIONS:
		var self_axis_is_greater_than_target_axis: bool = self.position[axis] < target_position[axis]
		rotation[axis] += ROTATIONAL_STRENGTH if self_axis_is_greater_than_target_axis else -ROTATIONAL_STRENGTH
		velocity -= velocity * velocity * ROTATIONAL_DRAG_STRENGTH * delta
	
	rotation += rotational_velocity
	position += velocity
	


func _on_bullet_moved(transform: Transform3D) -> void:
	target_position = transform.origin
	target_rotation = rotation.direction_to(transform.basis.get_euler())
	
