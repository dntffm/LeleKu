extends Control

var PauseButton
var ClosePauseDialog
func _ready():
	PauseButton = get_node("PauseBtn")
	ClosePauseDialog = get_node("Pause/ColorRect/Panel/CloseDialogButton")


func _on_PauseBtn_pressed():
	get_node("Pause").show()
	

func _on_Close_pressed():
	get_node("Pause").hide()


func _on_Quit_pressed():
	get_node("Pause").hide()
	get_node("ModalDialog").show()


func _on_No_pressed():
	get_node("ModalDialog").hide()


func _on_Yes_pressed():
	get_tree().quit()


func _on_Resume_pressed():
	get_node("Pause").hide()
