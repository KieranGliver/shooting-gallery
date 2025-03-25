extends HBoxContainer

const EmptyImage: Texture2D = preload("res://Assets/PNG/HUD/icon_bullet_empty_long.png")
const BulletImage: Texture2D = preload("res://Assets/PNG/HUD/icon_bullet_gold_long.png")

@export var max_ammo: int = 0

var ammo: int = 0:
	set(value):
		ammo = value
		_update_display()


func _ready():
	ammo = max_ammo


func reload():
	ammo = max_ammo


func shoot() -> bool:
	ammo -= 1
	if ammo < 0:
		reload()
		return false
	return true


func add_image(texture: Texture2D):
	var display = TextureRect.new()
	display.texture = texture
	add_child(display)
	move_child(display, 0) # Moves digit to front of Hbox


func _update_display():
	for child in get_children():
		if child is TextureRect:
			child.queue_free()
	
	for i in range(max_ammo):
		if i < ammo:
			add_image(BulletImage)
		else:
			add_image(EmptyImage)
