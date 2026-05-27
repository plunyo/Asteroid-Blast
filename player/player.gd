extends CharacterBody2D
class_name Player

@export var normal_speed: float = 300.0
@export var boost_speed: float = 450.0
@export var acceleration: float = 1200.0
@export var friction: float = 1000.0

func _physics_process(delta: float) -> void:
	look_at(get_global_mouse_position())

	var input_direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var speed: float = normal_speed if not Input.is_action_pressed("sprint") else boost_speed

	if input_direction != Vector2.ZERO:
		velocity = velocity.move_toward(input_direction * speed, acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)

	move_and_slide()
