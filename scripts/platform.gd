extends AnimatableBody3D

# =========================================================
# MOVING PLATFORM:
# set of blocks operating as a platform oscillating between two positions
# =========================================================

# =========================================================
# VARIABLES
# =========================================================
@export var initial_position := Vector3()
@export var final_position := Vector3()
@export var time : float = 2.0
@export var pause : float = 0.5

# =========================================================
# READY FUNCTION (calling the move function)
# =========================================================
func _ready() -> void:
	move()

# =========================================================
# FUNCTIONS
# =========================================================
# animating the movement via tweens
func move():
	var move_tween = create_tween()
	move_tween.tween_property(self, "position", final_position, time).set_trans(Tween.TRANS_CUBIC).set_delay(pause)
	move_tween.tween_property(self, "position", initial_position, time).set_trans(Tween.TRANS_CUBIC).set_delay(pause)
	await get_tree().create_timer(2 * time + 2 * pause).timeout
	move()
