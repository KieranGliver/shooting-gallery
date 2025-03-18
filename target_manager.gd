extends Node2D

const TargetPackedScene: PackedScene = preload("res://target.tscn")

@export var wave_length: int = 0
@export var wave_interval: int = 0
@export var target_velocity: Vector2 = Vector2.ZERO

var internal_timer: Timer = Timer.new()
var external_timer: Timer = Timer.new()

@onready var next_wave: Wave = generate_wave()


func _ready():
	add_child(internal_timer)
	add_child(external_timer)
	internal_timer.connect("timeout", _internal_timer_timeout)
	external_timer.connect("timeout", _external_timer_timeout)
	_external_timer_timeout()


func _internal_timer_timeout():
	#print("WaveManager: spawn")
	spawn_target()


func _external_timer_timeout():
	#print("WaveManager: load")
	load_wave(next_wave)
	next_wave = generate_wave()


func spawn_target():
	var target = TargetPackedScene.instantiate()
	add_child(target)
	target.velocity = target_velocity


func load_wave(wave: Wave):
	internal_timer.stop()
	external_timer.stop()
	
	internal_timer.wait_time = wave.interval
	external_timer.wait_time = wave.length
	
	internal_timer.start()
	external_timer.start()


func generate_wave():
	var wave := Wave.new()
	wave.interval = wave_interval
	wave.length = wave_length
	return wave
