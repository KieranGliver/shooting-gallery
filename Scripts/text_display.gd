extends Control

var go: bool = false:
	set(value):
		go_display.visible = value
		go = value
var game_over: bool = false:
	set(value):
		game_over_display.visible = value
		game_over = value
var ready_text: bool = false: # Can't name ready
	set(value):
		ready_text_display.visible = value
		ready_text = value
var time_up: bool = false:
	set(value):
		time_up_display.visible = value
		go = value

@onready var go_display: TextureRect = $Go
@onready var game_over_display: TextureRect = $GameOver
@onready var ready_text_display: TextureRect = $Ready
@onready var time_up_display: TextureRect = $TimeUp
