extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	get_tree().change_scene("res://main_menu/MainMenu.tscn")


func _on_next_pressed():
	get_tree().change_scene("res://main_menu/AboutScene2.tscn")


func _on_prev_pressed():
	get_tree().change_scene("res://main_menu/AboutScene.tscn")


func _on_next3_pressed():
	get_tree().change_scene("res://main_menu/AboutScene3.tscn")
