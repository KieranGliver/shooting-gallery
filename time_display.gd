extends NumberDisplay

@onready var little_hand: Timer = $LittleHand


func _on_little_hand_timeout() -> void:
	if data <= 0:
		little_hand.stop()
		GameManager.game_over()
		print("Tock: ", data)
	else:
		data -= 1
		print("Tick: ", data)
