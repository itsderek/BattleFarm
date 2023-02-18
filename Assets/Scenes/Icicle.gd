extends Area2D

var rng = RandomNumberGenerator.new()
var ice1 = preload("res://Assets/Sprites/Icicle1.png")
var ice2 = preload("res://Assets/Sprites/Icicle2.png")
var ice3 = preload("res://Assets/Sprites/Icicle3.png")
var ices = [ice1, ice2, ice3]

#var ice1sound = preload("res://Assets/Sounds/iceshard1.wav")
#var ice2sound = preload("res://Assets/Sounds/iceshard2.wav")
#var ice3sound = preload("res://Assets/Sounds/iceshard3.wav")
#var sounds = [ice1sound, ice2sound, ice3sound]

var speed = 150
var velocity = Vector2.ZERO
var maxtime = 4.0

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	var rint = rng.randi_range(0, 2)
	$Sprite.texture = ices[rint]
	#$AudioStreamPlayer2D.stream = sounds[rint]
	#$AudioStreamPlayer2D.autoplay = true
	var timer = Timer.new()
	timer.wait_time = maxtime
	timer.autostart = true
	add_child(timer)
	timer.connect("timeout", self, "on_timeout")

func _process(delta):
	position += velocity * delta
	speed += 5

func init(spawnspot, direction):
	rng.randomize()
	var rint = rng.randi_range(-60, 60)
	global_position.x = spawnspot.x + rint
	global_position.y = spawnspot.y
	velocity = direction.normalized() * speed
	rotation = get_angle_to(to_global(direction)) + 200

func on_timeout():
	self.queue_free()


func _on_Icicle_body_entered(body):
	body.take_damage(30)
	self.queue_free()
