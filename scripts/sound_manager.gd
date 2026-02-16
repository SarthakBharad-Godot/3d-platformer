extends Control

# =========================================================
# SOUND MANAGER:
# handling various sound effects and music throughout the game
# =========================================================

func _ready() -> void:
	play_menu_music()

func play_jump_sound():
	$Jump.play()

func play_hurt_sound():
	$Hurt.play()

func play_squash_sound():
	$Squash.play()

func play_coin_sound():
	$Coin.play()

func play_button_sound():
	$Button.play()

func play_fall_sound():
	$Fall.play()

func play_menu_music():
	$Menu.play()

func stop_menu_music():
	$Menu.stop()

func play_game_music():
	$Game.play()

func stop_game_music():
	$Game.stop()

func play_win_sound():
	$Win.play()

func stop_win_sound():
	$Win.stop()

func play_gameover_sound():
	$GameOver.play()

func stop_gameover_sound():
	$GameOver.stop()

func play_gamestart_sound():
	$GameStart.play()
