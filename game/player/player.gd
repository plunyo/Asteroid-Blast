extends CharacterBody2D
class_name Player

signal health_changed

@onready var shooting_component: ShootingComponent = $ShootingComponent
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var max_health: float = 1000.0
@export var speed: float = 450.0
@export var acceleration: float = 1200.0
@export var friction: float = 1000.0

var health: float = max_health

var fire_rate_upgrades: int = 0
var base_fire_rate: float = 0.5

func _ready() -> void:
	shooting_component.set_fire_cooldown(base_fire_rate)

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("shoot"):
		shooting_component.shoot(Vector2.from_angle(global_rotation), global_position)

	look_at(get_global_mouse_position())

	var input_direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if input_direction.length() > 1.0:
		input_direction = input_direction.normalized()

	var speed_scale := speed / 450.0
	var scaled_acceleration := acceleration * speed_scale
	var scaled_friction := friction * speed_scale

	if input_direction != Vector2.ZERO:
		velocity = velocity.move_toward(input_direction * speed, scaled_acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, scaled_friction * delta)

	move_and_slide()

func heal(hp: float) -> void:
	health = min(health + hp, max_health)
	health_changed.emit()

func hit(damage: float) -> void:
	health = max(health - damage, 0.0)
	animation_player.play("hitflash")

	if health <= 0:
		die()
	else:
		SoundManager.play("player_hit", 0.5)

	health_changed.emit()

func die() -> void:
	SoundManager.play("player_death")
	queue_free()
