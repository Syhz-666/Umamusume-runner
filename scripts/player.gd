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
		if Input.is_action_just_pressed("ui_accept"):
			has_started = true
		return

	GameManager.score += delta * 10.0
	velocity_y += GRAVITY * delta

	if Input.is_action_just_pressed("ui_accept") and global_position.y >= GROUND_Y:
		velocity_y = JUMP_VELOCITY

	if Input.is_action_just_pressed("shoot") and GameManager.fireball_cooldown <= 0.0:
		_shoot_fireball()

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


