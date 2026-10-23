extends Node3D


const THRUST_STRENGTH: float = 1.0

var target_position: Vector3i
var target_rotation: Quaternion
var velocity: Vector3i


func _physics_process(delta: float) -> void:
	const AXIES_IN_THREE_DIMENSIONS: int = 3
	for axis in AXIES_IN_THREE_DIMENSIONS:
		var self_axis_is_greater_than_target_axis: bool = self.position[axis] < target_position[axis]
		self.velocity[axis] += THRUST_STRENGTH if self_axis_is_greater_than_target_axis else -THRUST_STRENGTH
	


func _on_bullet_moved(transform: Transform3D) -> void:
	target_position = transform.origin
	target_rotation = transform.basis
	
