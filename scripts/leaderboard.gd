extends Node

const SAVE_PATH = "user://scores.json"
var scores: Array = []

func _ready() -> void:
	load_scores()

func load_scores() -> void:
	if FileAccess.file_exists(SAVE_PATH):
		var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		var text = file.get_as_text()
		file.close()
		var json = JSON.parse_string(text)
		if json != null and json is Array:
			scores = json
			return
	scores = []

func save_score(new_score: int) -> void:
	scores.append(new_score)
	scores.sort()
	scores.reverse()
	if scores.size() > 10:
		scores = scores.slice(0, 10)
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_string(JSON.stringify(scores, "\t"))
	file.close()

func get_top(count: int) -> Array:
	return scores.slice(0, mini(count, scores.size()))
