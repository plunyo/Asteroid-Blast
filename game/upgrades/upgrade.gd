extends Resource
class_name Upgrade

@export var name: String
@export var icon: Texture2D
@export var description: String

enum UpgradeType {
	FIRE_RATE,
	SPEED,
	#MAX_HEALTH,
	HEAL,
	#DEFENSE,
}

@export var type: UpgradeType
@export var value: float = 1.0

func apply(player: Player) -> void:
	match type:
		UpgradeType.FIRE_RATE:
			player.fire_rate_upgrades += 1

			var decay := pow(value, player.fire_rate_upgrades)
			player.shooting_component.set_fire_cooldown(player.base_fire_rate * decay)

		UpgradeType.SPEED:
			player.speed += value

		#UpgradeType.MAX_HEALTH:
			#player.max_health += value
			#player.health += value

		UpgradeType.HEAL:
			player.heal(value)

		#UpgradeType.DEFENSE:
			# placeholder for later (damage reduction system etc)
			#pass
