extends Node2D

var tiles: Array[float] = [-960.0, 0.0]
const TILE_WIDTH: float = 960.0
const GROUND_H: float = 40.0
const WRAP_LIMIT: float = -TILE_WIDTH * 1.5

func _process(delta: float) -> void:
	if GameManager.is_game_over or not GameManager.game_running:
		return
	var speed = GameManager.get_speed()
	for i in range(tiles.size()):
		tiles[i] -= speed * delta
		if tiles[i] <= WRAP_LIMIT:
			tiles[i] += TILE_WIDTH * tiles.size()
	queue_redraw()

func _draw() -> void:
	for x_pos in tiles:
		draw_rect(Rect2(x_pos, 0, TILE_WIDTH, GROUND_H), Color(0.5, 0.35, 0.2), true)
		draw_rect(Rect2(x_pos, 0, TILE_WIDTH, 3), Color(0.3, 0.2, 0.1), true)
