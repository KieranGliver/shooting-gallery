class_name Target
extends Node2D

var shot_hole: PackedScene = preload("res://shot_hole.tscn")

@onready var bullseye: Area2D = $Bullseye
@onready var front_sprite: Sprite2D = $Bullseye/FrontSprite
@onready var back_sprite: Sprite2D = $Bullseye/BackSprite
@onready var hole_container: Node2D = $holes


func _on_bullseye_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			spin(0.75)
			create_hole(to_local(event.position))


func spin(duration: float = 1.0):
	# Could do this using animation player
	# Need to fix animation overlap
	
	# Set up scale animation using tween
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(0, 1), duration/4)
	tween.tween_property(self, "scale", Vector2(1, 1), duration/4)
	tween.tween_property(self, "scale", Vector2(0, 1), duration/4)
	tween.tween_property(self, "scale", Vector2(1, 1), duration/4)
	
	# Wait until back should be displayed in animation
	await get_tree().create_timer(duration/4).timeout
	toggle_sprite()
	for child in hole_container.get_children():
		child.position.x = -child.position.x
	
	# Wait until front should be displayed in animation
	await get_tree().create_timer(duration/2).timeout
	toggle_sprite()
	for child in hole_container.get_children():
		child.position.x = -child.position.x


func toggle_sprite():
	front_sprite.visible = not front_sprite.visible
	back_sprite.visible = not back_sprite.visible


func create_hole(local_position: Vector2):
	var hole = shot_hole.instantiate()
	hole.position = local_position
	hole_container.add_child(hole)
