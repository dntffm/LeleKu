extends Control

var PauseButton
var ClosePauseDialog
var leleNode = preload("res://lele/Lele.tscn")
var pakanNode = preload("res://UI/Pakan.tscn")
var foodButton = false
func _ready():
	PauseButton = get_node("PauseBtn")
	get_node("Area2D").hide()
	
	#ClosePauseDialog = get_node("Pause/ColorRect/Panel/CloseDialogButton")


func _process(delta):
	if(foodButton):
		$Area2D.position = get_viewport().get_mouse_position()
		print($Area2D.get_colliding_bodies())
	

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


func _on_Music_pressed():
	print(get_node("Pause/Music"))

func _on_Timer_timeout():
	if $Grass/Timer/Timer.value < 20:
		$Grass/Timer/Timer.value += 1


func _on_Shop_pressed():
	get_node("ModalShop").show()

func _on_CloseShop_pressed():
	get_node("ModalShop").hide()	


func _on_Seeds_pressed():
	var paretnt = get_node("Grass")
	var lele = leleNode.instance()
	lele.position = Vector2(195+randi()%200+5,310+randi()%200+5)
	lele.z_index = 4
	lele.scale.x = 2.0
	lele.scale.y = 2.0
	lele.set("status","lapar")
	paretnt.add_child(lele)
	lele.connect("clicked",self,"handle_lele_clicked")
	


func _on_Food_pressed():
	foodButton = !foodButton
	if(foodButton):
		get_node("Area2D").show()
	else:
		get_node("Area2D").hide()


func _on_FoodClose_pressed():
	get_node("ModalFood").hide()

func _on_YellowFood_pressed():
	var paretnt = get_node("Pool")
	for x in paretnt.get_children():
		x.set_scale(Vector2(4,4))


func _on_Vitamin_pressed():
	get_node("ModalVitamins").show()


func _on_VitaminClose_pressed():
	get_node("ModalVitamins").hide()



func _on_Area2D_area_entered(area):
	print("a")

func handle_lele_clicked(lele):
	print(lele)


func _on_MovePool_pressed():
	var nodes = get_node("Grass").get_children()
	var pool2 = preload("res://pembesaran_pool/Pembesaran.tscn")
	
	for x in nodes:
		x.queue_free()
	#get_tree().change_scene("res://pembesaran_pool/Pembesaran.tscn")
