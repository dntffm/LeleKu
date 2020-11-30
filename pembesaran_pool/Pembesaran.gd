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


func _on_PauseBtn_pressed():
	get_node("Pause").show()


func _on_Close_pressed():
	get_node("Pause").hide()

func _on_Resume_pressed():
	get_node("Pause").hide()

func _on_Shop_pressed():
	get_node("ModalShop").show()


func _on_CloseShop_pressed():
	get_node("ModalShop").hide()

func _on_Food_pressed():
	get_node("ModalFood").show()

func _on_FoodClose_pressed():
	get_node("ModalFood").hide()

func _on_Vitamin_pressed():
	get_node("ModalVitamins").show()
	
func _on_VitaminClose_pressed():
	get_node("ModalVitamins").hide()


func _on_Quit_pressed():
	get_node("ModalDialog").show()
	get_node("Pause").hide()
func _on_Yes_pressed():
	get_tree().quit()

func _on_No_pressed():
	get_node("ModalDialog").hide()
