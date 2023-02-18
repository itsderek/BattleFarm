extends HBoxContainer

var mana_full = preload("res://Assets/Sprites/ManaPot.png")
var mana_half = preload("res://Assets/Sprites/HalfManaPot.png")
var mana_empty = preload("res://Assets/Sprites/EmptyManaPot.png")

func update_mana(value):
	for i in get_child_count():
		if value > i:
			get_child(i).texture = mana_full
		else:
			get_child(i).texture = mana_empty
