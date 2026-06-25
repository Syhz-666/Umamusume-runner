extends CanvasLayer

func _ready() -> void:
	GameManager.game_ended.connect(_on_game_ended)

func _process(_delta: float) -> void:
	$ScoreLabel.text = "Score: " + str(GameManager.get_score())
	$StartHint.visible = (GameManager.get_score() == 0 and not GameManager.is_game_over)

	var progress = 1.0 - GameManager.fireball_cooldown / GameManager.COOLDOWN_MAX
	$CooldownBox/CooldownFill.offset_top = 50.0 * (1.0 - progress)

func _on_game_ended() -> void:
	$GameOver/ScoreFinalLabel.text = "Score: " + str(GameManager.get_score())

	var top = Leaderboard.get_top(3)
	var labels = [$GameOver/Score1, $GameOver/Score2, $GameOver/Score3]
	for i in range(3):
		if i < top.size():
			labels[i].text = str(i + 1) + ". " + str(top[i])
		else:
			labels[i].text = str(i + 1) + ". ---"

	$GameOver.visible = true

func _input(event: InputEvent) -> void:
	if GameManager.is_game_over and event.is_action_pressed("ui_accept"):
		GameManager.start_game()
		get_tree().reload_current_scene()
