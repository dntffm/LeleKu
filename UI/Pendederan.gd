extends Control

var PauseButton
var ClosePauseDialog
var leleNode = preload("res://lele/Lele.tscn")
var pakanNode = preload("res://UI/Pakan.tscn")
var foodButton = false

var foodCount = 0
var fishCount = 0
var vitCount = 0
var path = "res://storage/storage.json"


func _ready():
	$Money/MoneyBadge/MoneyLabel.text = str(Global.data.money)
	$Pool/TextureRect/CountLabel.text = str(0) + " / 20"
	$Food/FoodBadge/FoodCount.text = str(0)
	$Vitamin/VitBadge/VitBadgeLabel.text = str(0)
	PauseButton = get_node("PauseBtn")
	get_node("Area2D").hide()
	
	#ClosePauseDialog = get_node("Pause/ColorRect/Panel/CloseDialogButton")

func _process(delta):
	if(foodButton):
		$Area2D.position = get_viewport().get_mouse_position()
	

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
	if paretnt.get_child_count() == 20:
		print("cant")
	else:
		var lele = leleNode.instance()
		var currMoney = Global.data.money - 300
		$Money/MoneyBadge/MoneyLabel.text = str(currMoney)
		lele.position = Vector2(195+randi()%200+5,310+randi()%200+5)
		lele.z_index = 0	
		lele.scale.x = 2.0
		lele.scale.y = 2.0
		paretnt.add_child(lele)
		
		
		var file = File.new()
		
		var data = Global.data
		data["money"] = currMoney
		data["pendederan"]["ikankecil"] += 1
		if file.open("res://storage/storage.json",File.WRITE) != 0:
			print("error opening file")
			return
		file.store_line(to_json(data))
		file.close()	
		
		$Pool/TextureRect/CountLabel.text = str(Global.data["pendederan"]["ikankecil"] + Global.data["pendederan"]["ikanbesar"]) + " / 20"
	


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
	var file = File.new()
	
	var data = Global.data
	data["pembesaran"]["ikankecil"] = data["pendederan"]["ikankecil"]
	data["pembesaran"]["ikanbesar"] = data["pendederan"]["ikanbesar"]
	if file.open("res://storage/storage.json",File.WRITE) != 0:
		print("error opening file")
		return
	file.store_line(to_json(data))
	file.close()	
	
	var nodes = get_node("Grass").get_children()
	
	var pool2 = preload("res://pembesaran_pool/Pembesaran.tscn")
	
	
	
	for x in nodes:
		x.queue_free()
	fishCount = 0
	get_tree().change_scene("res://pembesaran_pool/Pembesaran.tscn")


func _on_FoodShop_pressed():
	var currMoney = Global.data.money - 18000
	$Food/FoodBadge/FoodCount.text = str(Global.data.foodsA + 1)
	$Money/MoneyBadge/MoneyLabel.text = str(currMoney)
	var file = File.new()
	
	var data = Global.data
	data["foodsA"] = Global.data.foodsA + 1
	data["money"] = currMoney
	if file.open("res://storage/storage.json",File.WRITE) != 0:
		print("error opening file")
		return
	file.store_line(to_json(data))
	file.close()	


func _on_Vit25_pressed():
	var currMoney = Global.data.money - 10000
	$Vitamin/VitBadge/VitBadgeLabel.text = str(Global.data.vitaminA + Global.data.vitaminB + 1)
	$Money/MoneyBadge/MoneyLabel.text = str(currMoney)
	var file = File.new()
	
	var data = Global.data
	data["vitaminA"] = Global.data.vitaminA + 1
	data["money"] = currMoney
	if file.open("res://storage/storage.json",File.WRITE) != 0:
		print("error opening file")
		return
	file.store_line(to_json(data))
	file.close()	


func _on_Vit50_pressed():
	var currMoney = Global.data.money - 20000
	$Vitamin/VitBadge/VitBadgeLabel.text = str(Global.data.vitaminA + Global.data.vitaminB + 1)
	$Money/MoneyBadge/MoneyLabel.text = str(currMoney)
	var file = File.new()
	
	var data = Global.data
	data["vitaminB"] = Global.data.vitaminB + 1
	data["money"] = currMoney
	if file.open("res://storage/storage.json",File.WRITE) != 0:
		print("error opening file")
		return
	file.store_line(to_json(data))
	file.close()	
