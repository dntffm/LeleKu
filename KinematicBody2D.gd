extends KinematicBody2D
var status = randomize()

var motion = Vector2()


func _ready():
	print("OK")
	$AnimatedSprite.play("swim")
	$AnimatedSprite/FeedIndicator.hide()
	

func _physics_process(delta):
	if position.x > 600.0:
		#$AnimatedSprite.rotation_degrees = 180
		pass
	else:
		motion.x= 20
		global_position += motion * delta



func _on_Button_pressed():
	print(instance_from_id(get_instance_id()))
