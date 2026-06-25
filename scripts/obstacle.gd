extends Area2D

const CACTUS_TEX = preload("res://仙人掌.png")
const CACTUS_TEX_H: float = 702.0
const CACTUS_TEX_W: float = 514.0
const BIRD_TEX = preload("res://鸟.png")
const BIRD_TEX_SIZE: float = 500.0

var cactus_color: Color = Color.WHITE
var obstacle_width: float = 30.0
var obstacle_height: float = 40.0

func _ready() -> void:
	var img = Image.load_from_file("res://仙人掌.png")
	img.resize(1, 1, Image.INTERPOLATE_LANCZOS)
	cactus_color = img.get_pixel(0, 0)

func _process(delta: float) -> void:
	if GameManager.is_game_over:
		return
	global_position.x -= GameManager.get_speed() * delta
	if global_position.x < -550:
		queue_free()

func setup_cactus(height: float) -> void:
	add_to_group("cactus")
	obstacle_height = height
	var s = height / CACTUS_TEX_H
	obstacle_width = CACTUS_TEX_W * s
	var visual_s = s * 1.3

	$Sprite2D.texture = CACTUS_TEX
	$Sprite2D.scale = Vector2(visual_s, visual_s * 1.1)
	$Sprite2D.position = Vector2(0, -height * 1.3 / 2.0 + 4.0)
	$Sprite2D.modulate = Color.WHITE
	$Sprite2D.visible = true

	$CollisionShape2D.shape.size = Vector2(obstacle_width, height)
	$CollisionShape2D.position = Vector2(0, -height / 2.0)

func setup_bird(height: float) -> void:
	add_to_group("bird")
	obstacle_height = height
	var s = height / BIRD_TEX_SIZE
	obstacle_width = BIRD_TEX_SIZE * s
	var visual_s = s * 1.43

	$Sprite2D.texture = BIRD_TEX
	$Sprite2D.scale = Vector2(visual_s, visual_s)
	$Sprite2D.position = Vector2(5, -height * 1.43 / 2.0)
	$Sprite2D.modulate = cactus_color
	$Sprite2D.visible = true

	$CollisionShape2D.shape.size = Vector2(obstacle_width, height)
	$CollisionShape2D.position = Vector2(0, -height / 2.0)
