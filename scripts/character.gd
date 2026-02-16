extends CharacterBody3D

# =========================================================
# CHARACTER CONTROLLER:
# movement
# jumping
# camera alignment
# animations
# gravity
# fall/game-over
# =========================================================

# =========================================================
# CONSTANTS
# =========================================================
const CHARACTER_SPEED = 10
const JUMP_VELOCITY = 11

# =========================================================
# VARIABLES
# =========================================================
var xform : Transform3D
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

# =========================================================
# PHYSICS
# =========================================================
func _physics_process(delta: float) -> void:

	# reading the WASD/Arrow key input and getting the 2D directions
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")

	# robot animations
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		$AnimationPlayer.play("jump")
	elif is_on_floor() and input_dir != Vector2.ZERO:
		$AnimationPlayer.play("run")
	elif is_on_floor() and input_dir == Vector2.ZERO:
		$AnimationPlayer.play("idle")

	# camera movement/rotation (30° snaps)
	if Input.is_action_just_pressed("cam_left"):
		$CameraController.rotate_y(deg_to_rad(30))
	if Input.is_action_just_pressed("cam_right"):
		$CameraController.rotate_y(deg_to_rad(-30))

	# handling gravity while jumping
	if not is_on_floor():
		#velocity.y -= gravity * delta (another way to add gravity manually)
		velocity += get_gravity() * delta

	# handling jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		SoundManager.play_jump_sound()
		velocity.y = JUMP_VELOCITY

	# defining character direction relative to the camera
	var direction = ($CameraController.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	# rotating the character mesh relative to the camera
	if input_dir != Vector2(0,0):
		$Armature.rotation_degrees.y = $CameraController.rotation_degrees.y - rad_to_deg(input_dir.angle()) - 90

	# aligning the character mesh relative to the floor
	if is_on_floor() and input_dir != Vector2(0,0):
		align_with_floor($CharacterRayCast.get_collision_normal())
		global_transform = global_transform.interpolate_with(xform, 0.3)
	elif not is_on_floor():
		align_with_floor(Vector3.UP)
		global_transform = global_transform.interpolate_with(xform, 0.3)

	# updating the velocity and moving the character
	if direction:
		velocity.x = CHARACTER_SPEED * direction.x
		velocity.z = CHARACTER_SPEED * direction.z
	else:
		velocity.x = move_toward(velocity.x, 0, CHARACTER_SPEED)
		velocity.z = move_toward(velocity.z, 0, CHARACTER_SPEED)

	# built-in CharacterBody movement
	move_and_slide()

	# following the character with the camera rig
	$CameraController.position = lerp($CameraController.position, position, 0.125)

# =========================================================
# FUNCTONS
# =========================================================
# align character orientation relative to the floor normal
func align_with_floor(floor_normal):
	xform = global_transform
	xform.basis.y = floor_normal
	xform.basis.x = -xform.basis.z.cross(floor_normal)
	xform.basis = xform.basis.orthonormalized()

# detection of collision with the FallZone
func _on_fall_zone_body_entered(body: Node3D) -> void:
	SoundManager.play_fall_sound()
	SoundManager.stop_game_music()
	SoundManager.play_gameover_sound()
	get_tree().change_scene_to_file("res://scenes/gameover.tscn")

# character's attack functionality i.e. stomping enemies
func bounce():
	velocity.y = JUMP_VELOCITY * 0.7
