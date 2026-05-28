extends Node

const SOUNDS: Dictionary[String, AudioStream] = {
	"laser1": preload("res://assets/Bonus/sfx_laser1.ogg"),
	"laser2": preload("res://assets/Bonus/sfx_laser2.ogg"),
	"lose": preload("res://assets/Bonus/sfx_lose.ogg"),
	"shield_down": preload("res://assets/Bonus/sfx_shieldDown.ogg"),
	"shield_up": preload("res://assets/Bonus/sfx_shieldUp.ogg"),
	"two_tone": preload("res://assets/Bonus/sfx_twoTone.ogg"),
	"zap": preload("res://assets/Bonus/sfx_zap.ogg"),
	"enemy_death": preload("uid://dipsie1wolyre"),
	"enemy_hit": preload("uid://dyprcqgxkf00p")
}

func play(sound_name: String, pitch_variation: float = 0.0) -> void:
	var asp: AudioStreamPlayer = AudioStreamPlayer.new()
	add_child(asp)

	asp.stream = SOUNDS[sound_name]
	asp.pitch_scale += randf_range(-pitch_variation, pitch_variation)
	asp.finished.connect(asp.queue_free)

	asp.play()
