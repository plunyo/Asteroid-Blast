extends Node
class_name ShootingComponent

const RED_LASER_SCENE: PackedScene = preload("uid://b7n4kx2lv7ovq")

@onready var shoot_timer: Timer = $ShootTimer

@export_flags_2d_physics var physics_mask: int

func set_fire_cooldown(new_cooldown: float) -> void:
	shoot_timer.wait_time = new_cooldown

func shoot(direction: Vector2, from: Vector2) -> void:
	if not shoot_timer.is_stopped(): return

	var laser_instance: Laser = RED_LASER_SCENE.instantiate() as Laser
	WorldRefs.laser_container.add_child(laser_instance)

	laser_instance.direction = direction
	laser_instance.global_position = from
	laser_instance.collision_mask = physics_mask
	laser_instance.look_in_direction()

	SoundManager.play("laser", 0.3)

	shoot_timer.start()
