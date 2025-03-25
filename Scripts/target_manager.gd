@tool
extends Node2D

const TargetPackedScene: PackedScene = preload("res://Scenes/target.tscn")

@export var wave_interval: int = 0:
	set(value):
		wave_interval = value
		_on_set_wave_interval()
@export var terrain_texture: Texture2D:
	set(value):
		terrain_texture = value
		_on_set_terrain_texture()
@export_range(0, 500, 5) var terrain_y_offset: float = 0.0:
	set(value):
		terrain_y_offset = value
		update_terrain()
@export_subgroup("target_data")
@export var target_distance: float = 0.0:
	set(value):
		target_distance = value
		_on_set_target_distance()
@export_range(0, 1000, 25) var target_speed: float = 0.0:
	set(value):
		target_speed = value
		_on_set_target_speed()
@export_range(-360.0, 360.0) var target_angle: float = 0.0:
	set(value):
		target_angle = value
		_on_set_target_rotation()
@export_range(-200,200,10) var target_amplitude: float = 0.0
@export_range(-10,10,1) var target_wavelength: float = 0.0

var target_lifetime: float = 0.0

@onready var terrain: TextureRect = $Terrain
@onready var internal_timer: Timer = $Timers/Internal


func _ready():
	_on_set_terrain_texture()
	_on_set_wave_interval()
	_on_set_target_rotation()
	_on_set_target_speed()
	_on_set_target_distance()


func _internal_timer_timeout():
	#print("WaveManager: spawn")
	spawn_target()


func spawn_target():
	var target = TargetPackedScene.instantiate()
	add_child(target)
	move_child(target, 0) # Move target rendering behind terrain
	target.velocity = Vector2.RIGHT.rotated(deg_to_rad(target_angle)) * target_speed
	target.amplitude = target_amplitude
	target.wavelength = target_wavelength
	# Replace later
	await get_tree().create_timer(target_lifetime).timeout
	if target:
		target.queue_free()


func _on_set_wave_interval():
	if not internal_timer:
		return
	
	internal_timer.stop()
	if wave_interval > 0:
		internal_timer.wait_time = wave_interval
		internal_timer.start()
	print("Set Wave interval: ", wave_interval)


func _on_set_terrain_texture():
	if not terrain:
		return
	terrain.texture = terrain_texture


func _on_set_target_rotation():
	update_terrain()


func _on_set_target_speed():
	calculate_target_lifetime()


func _on_set_target_distance():
	calculate_target_lifetime()
	update_terrain()


func calculate_target_lifetime():
	if target_speed > 0:
		target_lifetime = target_distance / target_speed
	else:
		target_lifetime = 0.0


func update_terrain():
	if not terrain:
		return

	var angle_rad = deg_to_rad(target_angle)
	var direction = Vector2.RIGHT.rotated(angle_rad)

	terrain.size = Vector2(target_distance, terrain.size.y)

	# Determine if the terrain should be flipped (angle between 90°-270°)
	var is_backwards = target_angle > 90 and target_angle < 270

	var y_offset_vector = Vector2.UP.rotated(angle_rad) * terrain_y_offset

	if is_backwards:
		terrain.position = direction * target_distance + y_offset_vector
		terrain.rotation_degrees = target_angle - 180
	else:
		terrain.position = Vector2.ZERO - y_offset_vector
		terrain.rotation_degrees = target_angle
