extends NumberDisplay


func _process(delta: float) -> void:
	if GlobalData.score != data:
		data = GlobalData.score
