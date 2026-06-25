extends Node2D

var scroll_offset: float = 0.0
const TILE_WIDTH: float = 960.0
const GROUND_H: float = 40.0

func _process(delta: float) -> void:
	if GameManager.is_game_over or not GameManager.game_running:
		return
	scroll_offset += GameManager.get_speed() * delta
	scroll_offset = fmod(scroll_offset, TILE_WIDTH)
	queue_redraw()

func _draw() -> void:
	var start = -scroll_offset - TILE_WIDTH
	while start < 960.0 + TILE_WIDTH:
		draw_rect(Rect2(start, 0, TILE_WIDTH, GROUND_H), Color(0.5, 0.35, 0.2), true)
		draw_rect(Rect2(start, 0, TILE_WIDTH, 3), Color(0.3, 0.2, 0.1), true)
		start += TILE_WIDTH
