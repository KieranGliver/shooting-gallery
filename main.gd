extends Node2D

@export var round_length: int = 0

var events: Dictionary = {} # events[int] = Callable
var tick: int = 0

@onready var score_display = $CanvasLayer/ScoreDisplay
@onready var ammo_display = $CanvasLayer/AmmoDisplay
@onready var time_display = $CanvasLayer/TimeDisplay
@onready var text_display = $CanvasLayer/TextDisplay


func _ready():
	start()


func _process(delta: float) -> void:
	if score_display.data != GlobalData.score:
		score_display.data = GlobalData.score


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_mouse"):
		if not ammo_display.shoot():
			get_viewport().set_input_as_handled()


func start():
	time_display.data = round_length


func _on_little_hand_timeout() -> void:
	tick += 1
	time_display.data = round_length - tick
	print("Tick: ", tick)
	if tick > round_length:
		print("GameOver")
		GameManager.game_over()
