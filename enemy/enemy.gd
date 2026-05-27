extends CharacterBody2D
class_name Enemy

@export var speed: float = 200.0
@export var acceleration: float = 800.0
@export var friction: float = 900.0
@export var stop_threshold: float = 300.0

var target: Player

func _physics_process(delta: float) -> void:
	if not target:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
		move_and_slide()
		return

	var to_target: Vector2 = target.global_position - global_position
	var distance: float = to_target.length()

	if distance > 0:
		var direction: Vector2 = to_target / distance
		global_rotation = direction.angle()

		if distance <= stop_threshold:
			# run away instead of stopping
			var desired_velocity: Vector2 = -direction * speed
			velocity = velocity.move_toward(desired_velocity, acceleration * delta)
		else:
			var desired_velocity: Vector2 = direction * speed
			velocity = velocity.move_toward(desired_velocity, acceleration * delta)

	move_and_slide()

func _on_detection_body_entered(body: Node2D) -> void:
	if body is Player:
		target = body as Player
