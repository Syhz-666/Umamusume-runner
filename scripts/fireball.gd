extends Area2D

const SPEED: float = 500.0

func _ready() -> void:
	area_entered.connect(_on_area_entered)

func _process(delta: float) -> void:
	if GameManager.is_game_over:
		return
	global_position.x += SPEED * delta
	if global_position.x > 600:
		queue_free()

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("bird"):
		area.queue_free()
		GameManager.score += 50
		queue_free()
	elif area.is_in_group("cactus"):
		queue_free()


