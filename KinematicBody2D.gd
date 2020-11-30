extends KinematicBody2D
signal clicked(node)
func _ready():
	print("OK")
	$AnimatedSprite.play("swim")


func _input(event):
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == BUTTON_LEFT:
		print("wa")

