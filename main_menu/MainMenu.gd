extends Control

func _ready():
	get_node("NameTag/NametagLabel").text = "Halo, "+Global.data.username

func _on_Play_pressed():
	get_tree().change_scene("res://UI/Pendederan.tscn")


func _on_About_pressed():
	get_tree().change_scene("res://main_menu/AboutScene.tscn")



func _on_Quit_pressed():
	get_tree().quit()


func _on_TextureButton_pressed():
	get_tree().change_scene("res://UI/Help.tscn")
