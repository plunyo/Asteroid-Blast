extends Area2D
class_name UpgradePickup

@onready var sprite: Sprite2D = $Sprite

@export var upgrade: Upgrade

func _ready() -> void:
	sprite.texture = upgrade.icon

func _on_body_entered(body: Node2D) -> void:
	if not body is Player: return
	upgrade.apply(body)
	queue_free()
