extends VBoxContainer

const save_location = "user://highscore.save"

var scores: Array[Dictionary] = [
	{"name": "Usopp", "value": 50},
	{"name": "Nami", "value": 45},
	{"name": "Sanji", "value": 40},
	{"name": "Jinbe", "value": 35},
	{"name": "Robin", "value": 30},
	{"name": "Zoro", "value": 25},
	{"name": "Brooke", "value": 20},
	{"name": "Chopper", "value": 15},
	{"name": "Johnny", "value": 10},
	{"name": "Yosaku", "value": 5},
]

@onready var labels = [
	$Label,
	$Label2,
	$Label3,
	$Label4,
	$Label5,
	$Label6,
	$Label7,
	$Label8,
	$Label9,
	$Label10,
]


func _ready():
	update_scores()


func update_scores():
	sort_scores()
	for index in scores.size():
		labels[index].text = scores[index]["name"] + ": " + str(scores[index]["value"])


func insert_score(key: String, val: int):
	scores.append({"name": key, "value": val})
	sort_scores()
	scores.remove_at(scores.size())


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
