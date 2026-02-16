extends CharacterBody3D

# =========================================================
# ENEMY AI:
# patrols horizontally
# changes directions at walls/edges
# dies when player jumps on them
# gameover when player touches them from the sides
# =========================================================

# =========================================================
# VARIABLES
# =========================================================
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var enemy_speed = 2.0
@export var direction := Vector3(-1,0,0)
@export var turns_around = true
@export var hud : CanvasLayer
var turn := false

# =========================================================
# PHYSICS
# =========================================================
func _physics_process(delta: float) -> void:
	velocity.x = enemy_speed * direction.x
	velocity.z = enemy_speed * direction.z
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	move_and_slide()
	
	if is_on_wall() and not turn:
		turn_around()
	
	if not $EnemyRayCast.is_colliding() and is_on_floor() and not turn and turns_around:
		turn_around()

# =========================================================
# FUNCTIONS
# =========================================================
func turn_around():
	turn = true
	var dir = direction
	direction = Vector3.ZERO
	var turn_tween = create_tween()
	turn_tween.tween_property(self, "rotation_degrees", Vector3(0, 180, 0), 0.3).as_relative()
	await get_tree().create_timer(0.3).timeout
	direction.x = dir.x * -1
	direction.z = dir.z * -1
	turn = false

# =========================================================
# SIGNALS
# =========================================================
# detection of character overlapping with enemy from the sides
func _on_side_checker_body_entered(body: Node3D) -> void:
	SoundManager.play_hurt_sound()
	SoundManager.stop_game_music()
	SoundManager.play_gameover_sound()
	get_tree().change_scene_to_file("res://scenes/gameover.tscn")

# detection of character overlapping with enemy from the top and checking win condition
func _on_top_checker_body_entered(body: Node3D) -> void:
	$MonsterAnimationPlayer.play("Death")
	SoundManager.play_squash_sound()
	body.bounce()
	$SideChecker.set_collision_mask_value(1, false)
	$TopChecker.set_collision_mask_value(1, false)
	direction = Vector3.ZERO
	enemy_speed = 0
	Global.enemies += 1
	hud.get_node("EnemyPanel/EnemyLabel").text = str(Global.enemies)
	if Global.check_win_condition():
		SoundManager.stop_game_music()
		SoundManager.play_win_sound()
		await get_tree().create_timer(1.5).timeout
		get_tree().change_scene_to_file("res://scenes/win.tscn")
	else:
		await get_tree().create_timer(1.5).timeout
		queue_free()
