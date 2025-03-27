@tool
class_name Target
extends Node2D

const ShotHole: PackedScene = preload("res://Scenes/shot_hole.tscn")
const BrokenTarget: PackedScene = preload("res://Scenes/broken_target.tscn")

@export var velocity: Vector2 = Vector2.ZERO
@export var amplitude: float = 0.0
@export var wavelength: float = 0.0

var time_passed: float = 0.0
var base_y: float = 0.0
var sprite_data: TargetSpriteData = TargetSpriteData.new()

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var hole_container: Node2D = $holes
@onready var stick_sprite: Sprite2D = $Stick/Sprite
@onready var bullseye_front_sprite: Sprite2D = $Bullseye/FrontSprite
@onready var bullseye_back_sprite: Sprite2D = $Bullseye/BackSprite


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


func _on_stick_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			animation_player.stop()
			split()


func create_hole(local_position: Vector2):
	var hole = ShotHole.instantiate()
	hole.position = local_position
	hole_container.add_child(hole)


func flip_hole():
	for child in hole_container.get_children():
		child.position.x = -child.position.x


func split():
	var broken_target = BrokenTarget.instantiate()
	add_child(broken_target)
	broken_target.angular_velocity = randf_range(-5.0, 5.0)
	broken_target.linear_velocity = Vector2(randf_range(-500, 500), randf_range(-500, -300))
	bullseye_front_sprite.visible = false
	bullseye_back_sprite.visible = false
	for child in get_children():
		if child is Area2D:
			child.input_pickable = false
	remove_child(hole_container)
	broken_target.add_child(hole_container)
	stick_sprite.texture = sprite_data.stick_sprite[sprite_data.stick_sprite_index.BROKEN_METAL]
