extends Node

const SOUNDS: Dictionary[String, AudioStream] = {
	"laser":        preload("res://assets/Bonus/laser.mp3"),
	"player_hit":   preload("res://assets/Bonus/player_hit.mp3"),
	"player_death": preload("res://assets/Bonus/enemy_death.mp3"),
	"enemy_death":  preload("uid://dipsie1wolyre"),
	"enemy_hit":    preload("uid://dyprcqgxkf00p")
}

func play(sound_name: String, pitch_variation: float = 0.0) -> void:
	var asp: AudioStreamPlayer = AudioStreamPlayer.new()
	add_child(asp)

	asp.stream = SOUNDS[sound_name]
	asp.pitch_scale += randf_range(-pitch_variation, pitch_variation)
	asp.finished.connect(asp.queue_free)

	asp.play()
