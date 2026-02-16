extends Node

# =========================================================
# GLOBAL SCRIPT:
# handles requirements to win the game
# =========================================================

# =========================================================
# CONSTANTS
# =========================================================
const COINS_TO_WIN = 5
const NO_OF_ENEMIES = 2

# =========================================================
# VARIABLES
# =========================================================
var coins : int = 0
var enemies : int = 0

# =========================================================
# FUNCTIONS
# =========================================================
# checking win condition before displaying the win-screen
func check_win_condition() -> bool:
	return coins >= COINS_TO_WIN and enemies >= NO_OF_ENEMIES

# taking screenshots
func capture_screenshot():
	await RenderingServer.frame_post_draw
	var image = get_viewport().get_texture().get_image()
	# Use forward slashes (/) or escaped backslashes (\\) in GDScript strings
	var folder_path = var folder_path = "YOUR_PATH_HERE"
	var time = Time.get_datetime_dict_from_system()
	var file_name = "3d_platformer_%02d-%02d-%02d.png" % [time.hour, time.minute, time.second]
	var full_path = folder_path + file_name
	var error = image.save_png(full_path)
	if error == OK:
		print("Screenshot successfully saved to: ", full_path)
	else:
		print("Error saving screenshot. Error code: ", error)

func _input(event):
	if event.is_action_pressed("take_screenshot"):
		capture_screenshot()
