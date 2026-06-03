extends Control

@onready var health_label: Label = $MarginContainer/VboxContainer/HealthContainer/HealthLabel
@onready var wave_label: Label = $MarginContainer/VboxContainer/WaveContainer/WaveLabel

@export var enemy_manager: EnemyManager
@export var player: Player

func _ready() -> void:
	update_health_label()
	update_wave_label(enemy_manager.wave)
	enemy_manager.wave_ended.connect(update_wave_label)
	player.health_changed.connect(update_health_label)

func update_wave_label(wave: int) -> void:
	wave_label.text = str(wave)

func update_health_label() -> void:
	var health_ratio := player.health / player.max_health

	health_label.text = str(int(health_ratio * 100.0)) + "%"
	health_label.modulate = Color(
		1.0 - health_ratio,
		health_ratio,
		0.0
	)
