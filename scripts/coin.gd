extends Area2D

func _ready() -> void:
	add_to_group("coins")

func _process(delta: float) -> void:
	if GameManager.is_game_over:
		return
	global_position.x -= GameManager.get_speed() * delta
	if global_position.x < -550:
		queue_free()
