extends Enemy
class_name Enemy1

@export var stop_threshold: float = 150.0

func update_behavior(delta: float) -> void:
	if not target:
		slow_down(delta)
		return

	var direction := global_position.direction_to(target.global_position)
	var distance := global_position.distance_to(target.global_position)

	face_direction(direction, delta)

	if distance <= stop_threshold:
		move_towards(-direction, delta)
	else:
		move_towards(direction, delta)
