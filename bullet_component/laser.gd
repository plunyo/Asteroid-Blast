extends Area2D
class_name Bullet

@export var speed: float = 1200.0
@export var direction: Vector2 = Vector2.RIGHT

func _physics_process(delta: float) -> void:
	global_position += direction * speed * delta
