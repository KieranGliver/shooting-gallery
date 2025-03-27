extends PanelContainer

signal pressed

var score: int = 0:
	set(value):
		_on_set_score(value)
		score = value

@onready var score_display = $MarginContainer/VBoxContainer/NumberDisplay
@onready var line_edit = $MarginContainer/VBoxContainer/LineEdit


func _on_button_pressed() -> void:
	emit_signal("pressed")


func _on_set_score(value: int):
	if score_display:
		score_display.data = value
