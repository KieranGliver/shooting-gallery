extends Node2D


func _process(delta: float) -> void:
	global_position = global_position.lerp(get_global_mouse_position(), 8.0 * delta)
