extends KinematicBody2D
signal clicked(node)

var motion = Vector2()

func change_indicator():
	get_node("AnimatedSprite/Indicator").get_stylebox("panel","").bg_color = Color("#58a732")

func _ready():
	change_indicator()
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

