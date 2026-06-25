extends Area2D

const JUMP_VELOCITY: float = -550.0
const GRAVITY: float = 1500.0
const GROUND_Y: float = 200.0
const FIREBALL_SCENE = preload("res://scenes/fireball.tscn")

var velocity_y: float = 0.0
var has_started: bool = false

func _ready() -> void:
	area_entered.connect(_on_area_entered)

func _physics_process(delta: float) -> void:
	if GameManager.is_game_over:
		return

	if not has_started:
		if Input.is_action_just_pressed("ui_accept") or GameManager.touch_jump or GameManager.touch_shoot:
			has_started = true
			GameManager.game_running = true
		GameManager.touch_jump = false
		GameManager.touch_shoot = false
		return

	GameManager.score += delta * 10.0
	velocity_y += GRAVITY * delta

	var want_jump = Input.is_action_just_pressed("ui_accept") or GameManager.touch_jump
	if want_jump and global_position.y >= GROUND_Y:
		velocity_y = JUMP_VELOCITY
	GameManager.touch_jump = false

	var want_shoot = Input.is_action_just_pressed("shoot") or GameManager.touch_shoot
	if want_shoot and GameManager.fireball_cooldown <= 0.0:
		_shoot_fireball()
	GameManager.touch_shoot = false

	global_position.y += velocity_y * delta
	if global_position.y > GROUND_Y:
		global_position.y = GROUND_Y
		velocity_y = 0.0

func _shoot_fireball() -> void:
	var fb = FIREBALL_SCENE.instantiate()
	fb.global_position = Vector2(global_position.x + 25, global_position.y - 25)
	get_parent().add_child(fb)
	GameManager.fireball_cooldown = GameManager.COOLDOWN_MAX

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("coins"):
		area.queue_free()
		GameManager.score += 50
	else:
		GameManager.end_game()


