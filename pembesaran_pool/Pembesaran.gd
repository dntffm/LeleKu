extends Control

var leleNode = preload("res://lele/Lele.tscn")
var foodButton = false
var suppButton = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$TextureRect/Label.text = str(Global.data["pembesaran"]["ikanbesar"]) + " / 20"
	$Money/Money/MoneyLabel.text = str(Global.data.money)
	var fishes = Global.data["pembesaran"]["ikanbesar"] + Global.data["pembesaran"]["ikankecil"]
	$Vitamin/FoodBadge2/FoodBadgeLabel.text = str(Global.data.vitaminA + Global.data.vitaminB)
	get_node("ModalVitamins/50%/Sprite/Label").text = str(Global.data.vitaminB)
	get_node("ModalVitamins/25%/Sprite/Label").text = str(Global.data.vitaminA)
	$Food/FoodBadge/FoodBadgeLabel.text  = str(Global.data.foodsB)
	for x in range(fishes):
		var parent = get_node("Pool")
		var lele = leleNode.instance()
		lele.position = Vector2(195+randi()%200+5,310+randi()%200+5)
		lele.z_index = 0	
		lele.scale.x = 3.0
		lele.scale.y = 3.0
		parent.add_child(lele)
	for x in range(Global.playerhealth):
		var health = TextureRect.new()
		health.texture = load('res://assets/health.png')
		health.rect_scale = Vector2(0.2,0.2)
		
		$Pool/HBoxContainer.add_child(health)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(foodButton):
		$Area2D.position = get_viewport().get_mouse_position()
	if(suppButton):
		$Area2D.position = get_viewport().get_mouse_position()		


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
	#get_node("ModalFood").show()
	if(Global.data.foodsB == 0):
		print("Foods not avaliable")
	else:
		if get_node("Pool").get_children() == []:
			print("no fishes")
		else: 
			
			foodButton = !foodButton
			Global.pakanterbang = foodButton
			if(foodButton):
				get_node("Area2D").show()
			else:
				get_node("Area2D").hide()
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


func _on_MovePool_pressed():
	get_tree().change_scene("res://UI/Pendederan.tscn")


func _on_Food2_pressed():
	var currMoney = Global.data.money - 18000
	if currMoney > 0 :
		$Food/FoodBadge/FoodBadgeLabel.text = str(Global.data.foodsB + 20)
		$Money/Money/MoneyLabel.text = str(currMoney)
		var file = File.new()
		
		var data = Global.data
		data["foodsB"] = Global.data.foodsB + 20
		data["money"] = currMoney
		if file.open("res://storage/storage.json",File.WRITE) != 0:
			print("error opening file")
			return
		file.store_line(to_json(data))
		file.close()	


func _on_Vit25_pressed():
	var currMoney = Global.data.money - 10000
	if currMoney > 0:
		$Vitamin/FoodBadge2/FoodBadgeLabel.text = str(Global.data.vitaminA + Global.data.vitaminB)
		get_node("ModalVitamins/25%/Sprite/Label").text = str(Global.data.vitaminA+ 1) 
		$Money/Money/MoneyLabel.text = str(currMoney)
		var file = File.new()
		
		var data = Global.data
		data["vitaminA"] = Global.data.vitaminA + 1
		data["money"] = currMoney
		if file.open("res://storage/storage.json",File.WRITE) != 0:
			print("error opening file")
			return
		file.store_line(to_json(data))
		file.close()
	else:
		print("money gk cukup")	



func _on_Vit50_pressed():
	var currMoney = Global.data.money - 20000
	if currMoney > 0:
		$Vitamin/FoodBadge2/FoodBadgeLabel.text = str(Global.data.vitaminA + Global.data.vitaminB)
		$Money/Money/MoneyLabel.text = str(currMoney)
		get_node("ModalVitamins/50%/Sprite/Label").text = str(Global.data.vitaminB+ 1) 
		var file = File.new()
		
		var data = Global.data
		data["vitaminB"] = Global.data.vitaminB + 1
		data["money"] = currMoney
		if file.open("res://storage/storage.json",File.WRITE) != 0:
			print("error opening file")
			return
		file.store_line(to_json(data))
		file.close()	
	else:
		print("money gak cukup")


func _on_25_pressed():
	self.suppButton = !self.suppButton
	$ModalVitamins.hide()
	if(suppButton):
		Global.supplementterbang = true
		get_node("Area2D").show()
	else:
		Global.supplementterbang = false
		get_node("Area2D").hide()


func _on_Button_pressed():
	get_tree().change_scene("res://main_menu/MainMenu.tscn")
