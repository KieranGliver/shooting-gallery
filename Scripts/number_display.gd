class_name NumberDisplay
extends HBoxContainer

@export var data: int = 0:
	set(value): 
		data = value
		_update_display()
@export var icon_image: Texture2D

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
	data = data


func _update_display():
	for child in get_children():
		if child is TextureRect:
			child.queue_free()
	
	if data <= 0:
		add_image(number_image[0])
	else:
		# Iterates over digits in score adding as TextureRect
		var temp_score = data
		
		while temp_score > 0:
			add_image(number_image[fmod(temp_score, 10)]) # Last digit of temp_score
			temp_score = temp_score / 10
	
	# Add icon image to front of display
	if icon_image != null:
		add_image(icon_image)


func add_image(texture: Texture2D):
	var display = TextureRect.new()
	display.texture = texture
	add_child(display)
	move_child(display, 0) # Moves digit to front of Hbox
