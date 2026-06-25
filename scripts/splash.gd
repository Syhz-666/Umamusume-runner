extends CanvasLayer

var elapsed: float = 0.0
var can_start: bool = false

func _ready() -> void:
	$Fade.modulate = Color(1, 1, 1, 0)

func _process(delta: float) -> void:
	elapsed += delta
	if elapsed < 1.5:
		$Fade.modulate.a = min(1.0, elapsed / 1.5)
	elif not can_start and elapsed >= 3.5:
		can_start = true
		$Fade/Hint.visible = true

func _input(event: InputEvent) -> void:
	if not can_start:
		return
	if (event is InputEventKey and event.pressed) or (event is InputEventMouseButton and event.pressed) or (event is InputEventScreenTouch and event.pressed):
		get_tree().change_scene_to_file("res://scenes/main.tscn")
