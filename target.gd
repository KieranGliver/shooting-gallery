@tool
class_name Target
extends Node2D

const ShotHole: PackedScene = preload("res://shot_hole.tscn")

@export var velocity: Vector2 = Vector2.ZERO
@export var amplitude: float = 0.0
@export var wavelength: float = 0.0

var time_passed: float = 0.0
var base_y: float = 0.0

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var hole_container: Node2D = $holes


func _physics_process(delta: float) -> void:
	time_passed += delta
	base_y = base_y + velocity.y * delta
	position.x = position.x + velocity.x * delta
	if wavelength != 0:
		position.y = base_y + sin(time_passed * (TAU / wavelength)) * amplitude
	else:
		position.y = base_y


func _on_bullseye_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			animation_player.queue("spin")
			create_hole(to_local(event.position))
			GlobalData.score += 1


func create_hole(local_position: Vector2):
	var hole = ShotHole.instantiate()
	hole.position = local_position
	hole_container.add_child(hole)


func flip_hole():
	for child in hole_container.get_children():
		child.position.x = -child.position.x
