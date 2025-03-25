class_name TargetSpriteData
extends Resource

enum bullseye_sprite_index {
	TARGET_BACK,
	TARGET_COLOURED,
	TARGET_RED1,
	TARGET_RED2,
	TARGET_RED3,
	TARGET_WHITE,
}
enum stick_sprite_index {
	WOODEN,
	METAL,
	TAPED_WOODEN,
	BROKEN_WOODEN,
	BROKEN_METAL,
}

static var bullseye_sprite := [
	preload("res://Assets/PNG/Objects/target_back_outline.png"),
	preload("res://Assets/PNG/Objects/target_colored_outline.png"),
	preload("res://Assets/PNG/Objects/target_red1_outline.png"),
	preload("res://Assets/PNG/Objects/target_red2_outline.png"),
	preload("res://Assets/PNG/Objects/target_red3_outline.png"),
	preload("res://Assets/PNG/Objects/target_white_outline.png"),
]
static var stick_sprite := [
	preload("res://Assets/PNG/Objects/stick_wood_outline.png"),
	preload("res://Assets/PNG/Objects/stick_metal_outline.png"),
	preload("res://Assets/PNG/Objects/stick_woodFixed_outline.png"),
	preload("res://Assets/PNG/Objects/stick_wood_outline_broken.png"),
	preload("res://Assets/PNG/Objects/stick_metal_outline_broken.png"),
]
