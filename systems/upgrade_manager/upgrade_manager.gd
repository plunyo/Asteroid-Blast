extends Node2D
class_name UpgradeManager

const UPGRADE_PICKUP_SCENE: PackedScene = preload("uid://cp3xuyafixo71")

const HEAL: Upgrade = preload("uid://ctu2icocap5yq")
const FIRE_RATE: Upgrade = preload("uid://dql0yltdiiibi")
const SPEED: Upgrade = preload("uid://v18rc5spqvjm")

@export var player: Player
@export var enemy_manager: EnemyManager
@export var spawn_radius: float = 180.0

var upgrade_pool: Array[Upgrade] = [HEAL, FIRE_RATE, SPEED]

func _ready() -> void:
	randomize()

func spawn_random_upgrade(pos: Vector2 = Vector2.INF) -> UpgradePickup:
	if upgrade_pool.is_empty():
		return null

	var upgrade := upgrade_pool[randi() % upgrade_pool.size()]
	var spawn_position := pos

	if spawn_position == Vector2.INF:
		spawn_position = _get_default_spawn_position()

	return spawn_upgrade(upgrade, spawn_position)

func spawn_upgrade(upgrade: Upgrade, pos: Vector2) -> UpgradePickup:
	var upgrade_pickup := UPGRADE_PICKUP_SCENE.instantiate() as UpgradePickup
	if upgrade_pickup == null:
		return null

	upgrade_pickup.upgrade = upgrade
	add_child(upgrade_pickup)
	upgrade_pickup.global_position = pos

	return upgrade_pickup

func _get_default_spawn_position() -> Vector2:
	if is_instance_valid(player):
		var angle := randf() * TAU
		return player.global_position + Vector2.RIGHT.rotated(angle) * spawn_radius

	return global_position
