extends CharacterBody2D
class_name Enemy

const HIT_PARTICLES_SCENE := preload("uid://crhqy8br8tj1g")

@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export_group("Stats")
@export var max_health: float = 100.0
@export var speed: float = 300.0
@export var acceleration: float = 800.0
@export var friction: float = 900.0

var health: float
var target: Player

func _ready() -> void:
	health = max_health
	target = get_tree().current_scene.get_node("Player")

func _physics_process(delta: float) -> void:
	update_behavior(delta)
	move_and_slide()

func update_behavior(_delta: float) -> void:
	# override in child classes
	pass

func move_towards(direction: Vector2, delta: float) -> void:
	var desired_velocity := direction * speed
	velocity = velocity.move_toward(desired_velocity, acceleration * delta)

func slow_down(delta: float) -> void:
	velocity = velocity.move_toward(Vector2.ZERO, friction * delta)

func face_direction(direction: Vector2, delta: float) -> void:
	var target_rotation := direction.angle()
	global_rotation = rotate_toward(global_rotation, target_rotation, 5.0 * delta)

func hit(damage: float) -> void:
	health -= damage
	animation_player.play("hitflash")

	if health <= 0:
		die()
	else:
		SoundManager.play("enemy_hit", 0.5)

func die() -> void:
	spawn_hit_particles()
	SoundManager.play("enemy_death")
	queue_free()

func spawn_hit_particles() -> void:
	var particles: CPUParticles2D = HIT_PARTICLES_SCENE.instantiate()
 
	add_sibling(particles)
	particles.global_position = global_position
	particles.emitting = true

	particles.finished.connect(particles.queue_free)
