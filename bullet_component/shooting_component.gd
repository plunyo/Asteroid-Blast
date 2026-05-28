extends Node
class_name ShootingComponent

const RED_LASER_SCENE: PackedScene = preload("uid://b7n4kx2lv7ovq")

@onready var shoot_timer: Timer = $ShootTimer

func shoot(direction: Vector2, from: Vector2) -> void:
	if not shoot_timer.is_stopped(): return

	var laser_instance: Laser = RED_LASER_SCENE.instantiate() as Laser
	add_child(laser_instance)

	laser_instance.direction = direction
	laser_instance.global_position = from
	laser_instance.look_in_direction()

	SoundManager.play("laser2", 0.25)

	shoot_timer.start()
