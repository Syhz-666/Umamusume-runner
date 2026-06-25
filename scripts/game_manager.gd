extends Node

var score: float = 0.0
var base_speed: float = 300.0
var is_game_over: bool = false
var fireball_cooldown: float = 0.0
const COOLDOWN_MAX: float = 5.0

signal game_started
signal game_ended

func _process(delta: float) -> void:
	if not is_game_over:
		fireball_cooldown = max(0.0, fireball_cooldown - delta)

func start_game() -> void:
	score = 0.0
	base_speed = 300.0
	is_game_over = false
	fireball_cooldown = 0.0
	game_started.emit()

func end_game() -> void:
	if is_game_over:
		return
	is_game_over = true
	Leaderboard.save_score(int(score))
	game_ended.emit()

func get_speed() -> float:
	return min(base_speed + floor(score / 500.0) * 50.0, 2500.0)

func get_score() -> int:
	return int(score)
