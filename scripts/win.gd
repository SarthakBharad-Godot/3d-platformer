extends Control
# =========================================================
# WIN SCREEN:
# displayed upon success
# option to play again or go back to menu
# =========================================================

# =========================================================
# SIGNALS
# =========================================================
func _on_try_again_button_pressed() -> void:
	SoundManager.play_button_sound()
	SoundManager.stop_win_sound()
	get_tree().change_scene_to_file("res://scenes/level_one.tscn")

func _on_back_to_menu_button_pressed() -> void:
	SoundManager.play_button_sound()
	SoundManager.stop_win_sound()
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
