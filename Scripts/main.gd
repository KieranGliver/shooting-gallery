extends Node2D

enum State {IDLE, RUNNING}

@export var round_length: int = 0

var events: Dictionary = {} # events[int] = Callable
var tick: int = 0
var current: State = State.IDLE

@onready var wave_managers = $WaveManagers
@onready var score_display = $CanvasLayer/ScoreDisplay
@onready var ammo_display = $CanvasLayer/AmmoDisplay
@onready var time_display = $CanvasLayer/TimeDisplay
@onready var text_display = $CanvasLayer/TextDisplay
@onready var leaderboard = $CanvasLayer/Leaderboard
@onready var little_hand = $LittleHand


func _ready():
	start()


func _process(delta: float) -> void:
	if score_display.data != GlobalData.score:
		score_display.data = GlobalData.score


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_mouse"):
		if current == State.RUNNING:
			if not ammo_display.shoot(): # Reduces ammo_display ammo
				get_viewport().set_input_as_handled()


func _on_little_hand_timeout() -> void:
	tick += 1
	time_display.data = round_length - tick
	print("Tick: ", tick)
	
	if tick == 1:
		text_display.ready_text = true
	
	if tick == 4:
		text_display.ready_text = false
		text_display.go = true
	
	if tick == 5:
		text_display.go = false
	
	if tick == round_length:
		print("GameOver")
		game_over()
	
	if tick == round_length + 2:
		text_display.time_up = false
		leaderboard.visible = true


func start():
	time_display.data = round_length
	little_hand.start()
	current = State.RUNNING


func game_over():
	text_display.time_up = true
	for child in wave_managers.get_children():
		child.wave_interval = 0.0
	for node in get_tree().get_nodes_in_group("target"):
		node.queue_free()
	current = State.IDLE
