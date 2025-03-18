class_name Target
extends Node2D

const ShotHole: PackedScene = preload("res://shot_hole.tscn")

@export var velocity: Vector2 = Vector2.ZERO

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var hole_container: Node2D = $holes


func _physics_process(delta: float) -> void:
	position = position + velocity * delta


func _on_bullseye_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			animation_player.queue("spin")
			create_hole(to_local(event.position))
			GlobalData.score += 1


func _on_stick_area_entered(area: Area2D) -> void:
	if area.is_in_group("death"):
		queue_free()


func create_hole(local_position: Vector2):
	var hole = ShotHole.instantiate()
	hole.position = local_position
	hole_container.add_child(hole)


func flip_hole():
	for child in hole_container.get_children():
		child.position.x = -child.position.x
