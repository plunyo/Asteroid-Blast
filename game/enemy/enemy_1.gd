extends Enemy
class_name Enemy1

@onready var shooting_component: ShootingComponent = $ShootingComponent

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

	shooting_component.set_fire_cooldown(1.0)

	if has_line_of_sight(target):
		shooting_component.shoot(direction, global_position)
