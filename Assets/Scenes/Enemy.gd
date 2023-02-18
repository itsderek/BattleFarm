extends KinematicBody2D


var health = 200
var speed = 50
var just_damaged = false
onready var target = get_node("/root/BattleFarm/HoodedDude")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func take_damage(dmg):
	health -= dmg
	just_damaged = true
	if $Sprite/AnimationPlayer.is_playing():
		$Sprite/AnimationPlayer.stop()
	$Sprite/AnimationPlayer.play("damage_flash")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if health <= 0:
		self.queue_free()
	
	if just_damaged:
		var velocity = global_position.direction_to(target.global_position)
		move_and_collide(-velocity * speed * delta * 10)
		just_damaged = false
	else:
		var velocity = global_position.direction_to(target.global_position)
		var collision = move_and_collide(velocity * speed * delta)
		if collision:
			var collider = collision.collider
			if collider is Player:
				var dir = (collider.global_position - global_position).normalized()
				collider.take_damage(1, dir)
