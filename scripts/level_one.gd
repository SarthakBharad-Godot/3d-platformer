extends Node3D

# =========================================================
# GAME INITIALIZATION:
# resetting coin and enemy counter to zero
# =========================================================

# =========================================================
# READY FUNCTION
# =========================================================
func _ready() -> void:
	Global.coins = 0
	Global.enemies = 0
	SoundManager.play_gamestart_sound()
	SoundManager.play_game_music()
