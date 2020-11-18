extends Control

onready var scene_tree: = get_tree()
onready var profile_empty_overlay: ColorRect = get_node("Overlay")

var dialogEmpty: = false setget set_dialog

func set_dialog(value:bool) -> void:
	dialogEmpty = value
	scene_tree.paused = value
	profile_empty_overlay.visible = value
