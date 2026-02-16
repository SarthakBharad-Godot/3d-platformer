extends Area3D

# =========================================================
# COLLECTIBLE COIN:
# coin rotation animation
# incrementing score when a coin is picked up
# =========================================================

# =========================================================
# CONSTANTS
# =========================================================
const ROTATION_SPEED = 2

# =========================================================
# VARIABLES
# =========================================================
@export var hud : CanvasLayer

# =========================================================
# PROCESS FUNCTION (rotating the coin continuously at 60fps)
# =========================================================
func _process(delta: float) -> void:
	rotate_y(deg_to_rad(ROTATION_SPEED))

# =========================================================
# SIGNALS
# =========================================================
# detection of character overlapping with coin
# trigger pick-up animation and checking win condition
func _on_body_entered(body: Node3D) -> void:
	Global.coins += 1
	SoundManager.play_coin_sound()
	hud.get_node("CoinPanel/CoinLabel").text = str(Global.coins)
	if Global.check_win_condition():
		SoundManager.stop_game_music()
		SoundManager.play_win_sound()
		get_tree().change_scene_to_file("res://scenes/win.tscn")
	set_collision_layer_value(3, false)
	set_collision_mask_value(1, false)
	$CoinAnimation.play("bounce")

# removing the coin
func _on_coin_animation_animation_finished(anim_name: StringName) -> void:
	queue_free()
