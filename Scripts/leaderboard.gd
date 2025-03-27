extends PanelContainer

signal pressed

const save_location = "user://highscore.save"

var scores: Array[Dictionary] = [
	{"name": "Usopp", "value": 50},
	{"name": "Nami", "value": 40},
	{"name": "Sanji", "value": 30},
	{"name": "Zoro", "value": 20},
	{"name": "Luffy", "value": 10},
]

@onready var labels = [
	$MarginContainer/VBoxContainer/Label,
	$MarginContainer/VBoxContainer/Label2,
	$MarginContainer/VBoxContainer/Label3,
	$MarginContainer/VBoxContainer/Label4,
	$MarginContainer/VBoxContainer/Label5,
]


func _ready():
	update_scores()


func _on_restart_button_pressed() -> void:
	emit_signal("pressed")


func update_scores():
	sort_scores()
	for index in scores.size():
		labels[index].text = scores[index]["name"] + ": " + str(scores[index]["value"] as int)


func insert_score(key: String, val: int):
	scores.append({"name": key, "value": val})
	sort_scores()
	scores.pop_back()


func sort_scores():
	scores.sort_custom(func(a,b): return a["value"] > b["value"])


func save_scores():
	var save_file = FileAccess.open(save_location, FileAccess.WRITE)
	for line in scores:
		var json_string = JSON.stringify(line)
		save_file.store_line(json_string)


func load_scores():
	if not FileAccess.file_exists(save_location):
		return # Error! No file to load
	
	scores.clear()
	
	var save_file = FileAccess.open(save_location, FileAccess.READ)
	while save_file.get_position() < save_file.get_length():
		var json_string = save_file.get_line()
		
		var json = JSON.new()
		
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			return
		scores.append(json.data)
