extends KinematicBody2D

var speed = 200  # speed in pixels/sec
var velocity = Vector2.ZERO
#const fireball = preload("res://Fireball.tscn")
export(PackedScene) var fireball = preload("res://Assets/Scenes/Fireball.tscn")

func get_input():
	velocity = Vector2.ZERO
	if Input.is_action_pressed('right'):
		velocity.x += 1
	if Input.is_action_pressed('left'):
		velocity.x -= 1
	if Input.is_action_pressed('down'):
		velocity.y += 1
	if Input.is_action_pressed('up'):
		velocity.y -= 1
	# Make sure diagonal movement isn't faster
	velocity = velocity.normalized() * speed

	if Input.is_action_just_pressed("leftclick", true):
		var fball = fireball.instance()
		var dir = get_global_mouse_position() - position
		fball.init(global_position, dir)
		get_parent().add_child(fball)

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)
