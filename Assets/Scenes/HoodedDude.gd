extends KinematicBody2D

var mana = 5
var speed = 200  # speed in pixels/sec
var velocity = Vector2.ZERO
onready var sprite = get_node("Sprite")
#const fireball = preload("res://Fireball.tscn")
export(PackedScene) var fireball = preload("res://Assets/Scenes/Fireball.tscn")
var icicle = preload("res://Assets/Scenes/Icicle.tscn")
var icicle_ready = true

func get_input(delta):
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
		sprite.flip_h = false
	else:
		sprite.flip_h = true
	
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
	
	if Input.is_action_pressed("rightclick", true) and icicle_ready:
		icicle_ready = false
		var icicle_timer = Timer.new()
		icicle_timer.wait_time = 0.2
		icicle_timer.autostart = true
		add_child(icicle_timer)
		icicle_timer.connect("timeout", self, "ice_timeout")
		
		if mana == 0:
			return
		#mana -= 1
		$Control/ManaBar.update_mana(mana)
		var ice_origin = $IcicleOrigin.global_position
		var ice = icicle.instance()
		var dir = get_global_mouse_position() - ice_origin
		ice.init(ice_origin, dir)
		get_parent().add_child(ice)

func _physics_process(delta):
	get_input(delta)
	velocity = move_and_slide(velocity)


func ice_timeout():
	icicle_ready = true

func _on_Timer_timeout():
	mana += 1
	mana = min(mana, 5)
	$Control/ManaBar.update_mana(mana)
