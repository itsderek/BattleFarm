extends Area2D


var speed = 500
var velocity = Vector2.ZERO
var maxtime = 2.0 # adjust this in seconds
export(PackedScene) var fireparticles = preload("res://Assets/Scenes/FireballExplosion.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var timer = Timer.new()
	timer.wait_time = maxtime
	timer.autostart = true
	add_child(timer)
	timer.connect("timeout", self, "on_timeout")
	$Tween.interpolate_property($Sprite, "scale", Vector2(0.2, 0.2), Vector2(1,1), 0.2)
	$Tween.start()

func on_timeout():
	self.queue_free()

func init(spawnspot, direction):
	global_position = spawnspot
	velocity = direction.normalized() * speed
	rotation = get_angle_to(to_global(direction))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += velocity * delta



func _on_Fireball_body_entered(body):
	var fparticles = fireparticles.instance()
	var loc = global_position
	fparticles.init(loc)
	get_parent().get_parent().add_child(fparticles)
	body.takeDamage(50)
	self.queue_free()
	
