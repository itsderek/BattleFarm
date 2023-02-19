extends Node2D

var opengate = false
var closegate = false
var closedelay = 3
var min_height
var max_height

# Called when the node enters the scene tree for the first time.
func _ready():
	min_height = $Gate.global_position.y
	max_height = $Gate.global_position.y - 60


func gate_open():
	opengate = true
	$Gate/Particles2D.emitting = true
	$Gate/Particles2D2.emitting = true
	$Gate/GateTimer.start(0.1)

func gate_close():
	closegate = true
	$Gate/Particles2D.emitting = true
	$Gate/Particles2D2.emitting = true
	$Gate/GateTimer.start(0.1)


func _on_Timer_timeout():
	gate_open()


func _on_GateTimer_timeout():
	if opengate == true and $Gate.global_position.y > max_height:
		$Gate.global_position.y -= 1

	if closegate == true and $Gate.global_position.y < min_height and closedelay < 0:
		$Gate.global_position.y += 1
		$Gate/Particles2D.emitting = true
		$Gate/Particles2D2.emitting = true

	if opengate == true and $Gate.global_position.y <= max_height:
		opengate = false
		closegate = true
		$Gate/Particles2D.emitting = false
		$Gate/Particles2D2.emitting = false

	if closegate == true and closedelay > 0:
		closedelay -= 0.1

	if closegate == true and $Gate.global_position.y >= min_height:
		$Gate/Particles2D.emitting = false
		$Gate/Particles2D2.emitting = false
		$Gate/GateTimer.stop()
