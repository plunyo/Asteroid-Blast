extends Camera2D
class_name Camera

@export var target: Node2D
@export var follow_speed: float = 8.0

func _physics_process(delta: float) -> void:
	if target == null:
		return

	global_position = global_position.lerp(target.global_position, follow_speed * delta)
