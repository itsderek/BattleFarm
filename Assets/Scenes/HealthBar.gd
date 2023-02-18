extends HBoxContainer

var heart_full = preload("res://Assets/Sprites/HeartFull.png")
var heart_half = preload("res://Assets/Sprites/HeartHalf.png")
var heart_empty = preload("res://Assets/Sprites/HeartEmpty.png")

func update_health(value):
	for i in get_child_count():
		if value > i:
			get_child(i).texture = heart_full
		else:
			get_child(i).texture = heart_empty
