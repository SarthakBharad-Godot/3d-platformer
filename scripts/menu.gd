extends Control

# =========================================================
# MENU INITIALIZATION:
# the screen displayed when the player first starts the game 
# =========================================================

# =========================================================
# SIGNALS
# =========================================================
func _on_play_button_pressed() -> void:
	SoundManager.play_button_sound()
	SoundManager.stop_menu_music()
	get_tree().change_scene_to_file("res://scenes/level_one.tscn")
