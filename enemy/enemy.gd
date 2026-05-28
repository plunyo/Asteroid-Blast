extends CharacterBody2D
class_name Enemy

@export var health: float = 100.0
@export var speed: float = 200.0
@export var acceleration: float = 800.0
@export var friction: float = 900.0
@export var stop_threshold: float = 300.0

var target: Player

func _ready() -> void:
	target = get_tree().current_scene.get_node("Player")

func hit(damage: float) -> void:
	health -= damage
	if health <= 0:
		queue_free()

func _physics_process(delta: float) -> void:
	if not target:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
		move_and_slide()
		return

	var to_target: Vector2 = target.global_position - global_position
	var distance: float = to_target.length()

	if distance > 0:
		var direction: Vector2 = to_target / distance

		var target_rotation: float = direction.angle()
		global_rotation = rotate_toward(global_rotation, target_rotation, 5.0 * delta)

		if distance <= stop_threshold:
			# run away instead of stopping
			var desired_velocity: Vector2 = -direction * speed
			velocity = velocity.move_toward(desired_velocity, acceleration * delta)
		else:
			var desired_velocity: Vector2 = direction * speed
			velocity = velocity.move_toward(desired_velocity, acceleration * delta)

	move_and_slide()
