extends CanvasLayer

# =========================================================
# HEADS-UP DISPLAY:
# displays the coins collected and enemy defeated count
# =========================================================

# =========================================================
# READY FUNCTION 
# =========================================================
func _ready() -> void:
	$CoinPanel/CoinLabel.text = str(0)
	$EnemyPanel/EnemyLabel.text = str(0)
