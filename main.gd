extends Node2D



@onready var ammo_display = $CanvasLayer/AmmoDisplay

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_mouse"):
		if not ammo_display.shoot():
			get_viewport().set_input_as_handled()
