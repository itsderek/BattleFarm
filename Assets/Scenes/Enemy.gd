extends KinematicBody2D


var health = 200
var speed = 50
onready var target = get_node("/root/BattleFarm/HoodedDude")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func takeDamage(damage):
	health -= damage

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if health <= 0:
		self.queue_free()

	var velocity = global_position.direction_to(target.global_position)
	move_and_collide(velocity * speed * delta)
