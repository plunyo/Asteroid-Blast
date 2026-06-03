extends Area2D
class_name Laser

@export var speed: float = 2000.0
@export var damage: float = 100.0
@export var direction: Vector2 = Vector2.RIGHT

func _ready() -> void:
	look_in_direction()

func look_in_direction() -> void:
	global_rotation = direction.angle()

func _physics_process(delta: float) -> void:
	global_position += direction * speed * delta

func _on_body_entered(body: Node2D) -> void:
	if not body.has_method("hit"): return

	body.hit(damage)
	queue_free()

func _on_free_timer_timeout() -> void:
	queue_free()
