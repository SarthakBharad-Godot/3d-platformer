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
