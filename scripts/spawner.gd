extends Node2D

const OBSTACLE_SCENE = preload("res://scenes/obstacle.tscn")
const COIN_SCENE = preload("res://scenes/coin.tscn")

@onready var timer: Timer = $Timer

func _ready() -> void:
	timer.timeout.connect(_on_timeout)

func _on_timeout() -> void:
	if GameManager.is_game_over:
		return
	spawn()
	var interval = randf_range(0.8, 2.2) * (300.0 / GameManager.get_speed())
	timer.wait_time = max(interval, 0.4)
	timer.start()

func spawn() -> void:
	var obs = OBSTACLE_SCENE.instantiate()
	obs.global_position = Vector2(520, 200)

	if randf() < 0.3 and GameManager.get_score() > 200:
		obs.setup_bird(25.0)
		obs.global_position.y = 170.0 + randf_range(-10, 20)
	else:
		obs.setup_cactus(randf_range(30.0, 55.0))

	add_child(obs)

	if randf() < 0.35:
		var coin = COIN_SCENE.instantiate()
		coin.global_position = Vector2(520 + randf_range(50.0, 200.0), randf_range(80.0, 140.0))
		add_child(coin)
