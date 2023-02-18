extends KinematicBody2D

var mana = 5
var speed = 200  # speed in pixels/sec
var velocity = Vector2.ZERO
onready var sprite = get_node("Sprite")
#const fireball = preload("res://Fireball.tscn")
export(PackedScene) var fireball = preload("res://Assets/Scenes/Fireball.tscn")

func update_flip(flipped):
	sprite.flip_h = flipped
	if flipped:
		$Trail.scale.x = -1
	else:
		$Trail.scale.x = 1
	

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
	
	if (get_global_mouse_position() - position).x >= 0:
		update_flip(false)
	else:
		update_flip(true)
	
	if Input.is_action_just_pressed("leftclick", true):
		if mana == 0:
			return
		mana -= 1
		$Control/ManaBar.update_mana(mana)
		var fball_origin = $ProjectileOrigin.global_position
		var fball = fireball.instance()
		var dir = get_global_mouse_position() - fball_origin
		fball.init(fball_origin, dir)
		get_parent().add_child(fball)

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)


func _on_Timer_timeout():
	mana += 1
	mana = min(mana, 5)
	$Control/ManaBar.update_mana(mana)
