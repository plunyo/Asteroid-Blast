extends Node2D
class_name EnemyManager

const ENEMY_SCENE: PackedScene = preload("res://enemy/enemy_1.tscn")

signal wave_started(wave: int)
signal wave_ended(wave: int)

@export var player: Player

@export var spawn_radius: float = 900.0
@export var min_spawn_radius: float = 650.0

@export var base_max_enemies: int = 12
@export var max_enemies_per_wave: int = 3

@export var base_spawn_interval: float = 3
@export var min_spawn_interval: float = 0.25
@export var spawn_interval_reduction_per_wave: float = 0.08

@export var level_duration: float = 45.0
@export var max_wave: int = 999

@onready var spawn_timer: Timer = $SpawnTimer
@onready var level_timer: Timer = $LevelTimer

var wave: int = 1
var active_enemies: Array[Enemy] = []

func _ready() -> void:
	randomize()
	_start_wave()

func _start_wave() -> void:
	update_spawn_timer()
	level_timer.wait_time = level_duration
	level_timer.start()
	wave_started.emit(wave)

func _on_spawn_timer_timeout() -> void:
	if not is_instance_valid(player):
		return

	_cleanup_enemies()

	if active_enemies.size() >= get_current_max_enemies():
		update_spawn_timer()
		return

	var enemy := ENEMY_SCENE.instantiate() as Enemy
	if enemy == null:
		return

	var spawn_position := _get_spawn_position()
	enemy.global_position = spawn_position
	enemy.target = player

	add_child(enemy)
	active_enemies.append(enemy)

	update_spawn_timer()

func _on_level_timer_timeout() -> void:
	wave_ended.emit(wave)

	if wave < max_wave:
		wave += 1

	update_spawn_timer()
	level_timer.wait_time = level_duration
	level_timer.start()


func get_current_max_enemies() -> int:
	return base_max_enemies + ((wave - 1) * max_enemies_per_wave)

func get_current_spawn_interval() -> float:
	var interval := base_spawn_interval - ((wave - 1) * spawn_interval_reduction_per_wave)
	return max(min_spawn_interval, interval)

func update_spawn_timer() -> void:
	spawn_timer.wait_time = get_current_spawn_interval()
	spawn_timer.start()

func _get_spawn_position() -> Vector2:
	var angle := randf() * TAU
	var distance := randf_range(min_spawn_radius, spawn_radius)
	var direction := Vector2.RIGHT.rotated(angle)

	return player.global_position + direction * distance

func _cleanup_enemies() -> void:
	for i in range(active_enemies.size() - 1, -1, -1):
		if not is_instance_valid(active_enemies[i]):
			active_enemies.remove_at(i)
