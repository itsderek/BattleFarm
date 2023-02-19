extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var enemy = preload("res://Assets/Scenes/Enemy.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_Timer_timeout():
	$MonsterGate.gate_open()
	var e = enemy.instance()
	add_child(e)
	e.global_position = $SpawnPoints/Spawn1.global_position
	
	e = enemy.instance()
	add_child(e)
	e.global_position = $SpawnPoints/Spawn2.global_position
	
	e = enemy.instance()
	add_child(e)
	e.global_position = $SpawnPoints/Spawn3.global_position
