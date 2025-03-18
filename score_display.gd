extends HBoxContainer

var score: int = 0:
	set(value): 
		score = value
		_update_display()
var number_image = [
	preload("res://Assets/PNG/HUD/text_0_small.png") as Texture2D,
	preload("res://Assets/PNG/HUD/text_1_small.png") as Texture2D,
	preload("res://Assets/PNG/HUD/text_2_small.png") as Texture2D,
	preload("res://Assets/PNG/HUD/text_3_small.png") as Texture2D,
	preload("res://Assets/PNG/HUD/text_4_small.png") as Texture2D,
	preload("res://Assets/PNG/HUD/text_5_small.png") as Texture2D,
	preload("res://Assets/PNG/HUD/text_6_small.png") as Texture2D,
	preload("res://Assets/PNG/HUD/text_7_small.png") as Texture2D,
	preload("res://Assets/PNG/HUD/text_8_small.png") as Texture2D,
	preload("res://Assets/PNG/HUD/text_9_small.png") as Texture2D,
]


func _ready():
	score = score


func _update_display():
	for child in get_children():
		child.queue_free()
	
	if score == 0:
		var number_display = TextureRect.new()
		number_display.texture = number_image[0]
		add_child(number_display)
	
	# Iterates over digits in score adding as TextureRect
	var temp_score = score
	
	while temp_score > 0:
		var number_display = TextureRect.new()
		number_display.texture = number_image[fmod(temp_score, 10)]
		add_child(number_display)
		move_child(number_display, 0)
		temp_score = temp_score / 10
	
