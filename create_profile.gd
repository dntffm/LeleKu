extends Node
var profileDialogPopUp
var dismissDialog
func _ready():
	profileDialogPopUp = get_node("Popup")
	dismissDialog = get_node("Popup/ColorRect/Button")
	pass
func _on_Button_pressed():
	var lineEditText = get_node("LineEdit").text
	if(lineEditText == ""):
		profileDialogPopUp.show()
		pass
	else:
		get_tree().change_scene("res://main_menu/MainMenu.tscn")
func _on_Dismiss_Button_pressed():
	profileDialogPopUp.hide()
	pass # Replace with function body.
