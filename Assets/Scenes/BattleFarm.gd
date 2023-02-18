extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var enemy = preload("res://Assets/Scenes/Enemy.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_Timer_timeout():
	var e = enemy.instance()
	e.global_position = Vector2(100, 100)
	add_child(e)
