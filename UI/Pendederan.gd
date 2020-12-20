extends Control

var PauseButton
var ClosePauseDialog
var leleNode = preload("res://lele/Lele.tscn")
var pakanNode = preload("res://UI/Pakan.tscn")
var foodButton = false
var supplementButton = false

var adddirt = true
var foodCount = 0
var fishCount = 0
var vitCount = 0
var path = "res://storage/storage.json"
var dirtimer = 0

func _ready():
	$Money/MoneyBadge/MoneyLabel.text = str(Global.data.money)
	$Pool/TextureRect/CountLabel.text = str(Global.data["pendederan"]["ikankecil"]) + " / 20"
	$Food/FoodBadge/FoodCount.text = str(Global.data.foodsA)
	$Vitamin/VitBadge/VitBadgeLabel.text = str(Global.data.vitaminA + Global.data.vitaminB)
	get_node("ModalVitamins/25%/vit25badge/Label").text = str(Global.data.vitaminA)
	get_node("ModalVitamins/50%/vit50badge/Label").text = str(Global.data.vitaminB)
	for x in range(Global.playerhealth):
		var health = TextureRect.new()
		health.texture = load('res://assets/health.png')
		health.rect_scale = Vector2(0.2,0.2)
		
		$Pool/HBoxContainer.add_child(health)
	
	PauseButton = get_node("PauseBtn")
	get_node("Area2D").hide()
	
	for x in range(Global.data["pendederan"]["ikankecil"]):
		var lele = leleNode.instance()
		var paretnt = get_node("Grass")
		lele.position = Vector2(195+randi()%200+5,310+randi()%200+5)
		lele.z_index = 0	
		lele.scale.x = 2.0
		lele.scale.y = 2.0
		paretnt.add_child(lele)
	#ClosePauseDialog = get_node("Pause/ColorRect/Panel/CloseDialogButton")

func _process(delta):
	var kotorannode = preload("res://UI/Dirt.tscn")
	var kotoran = kotorannode.instance()
	kotoran.position = Vector2(rand_range(199.0,1122.0),rand_range(60.0,572.0))
	
	if adddirt:
		dirtimer = dirtimer+1
		
	if dirtimer > 100 :
		$Kotoran.add_child(kotoran)
		dirtimer = 0
	if(foodButton):
		$Area2D.position = get_viewport().get_mouse_position()
	if(supplementButton):
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
	if(Global.data.foodsA == 0):
		print("Foods not avaliable")
	else:
		if get_node("Grass").get_children() == []:
			print("no fishes")
		else: 
			print(get_node("Grass").get_children()[0].hungryVal)
			foodButton = !foodButton
			Global.pakanterbang = foodButton
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


func _on_MovePool_pressed():
	var nodes = get_node("Grass").get_children()
	var temp = []
	for x in nodes:
		if x.lelehidup:
			if x.readymove:
				temp.append(x)
		else:
			temp = []
			break
	
	if(temp != []):	
		get_tree().change_scene("res://pembesaran_pool/Pembesaran.tscn")
		var file = File.new()
	
		var data = Global.data
		data["pembesaran"]["ikanbesar"] = len(temp)
		data["pendederan"]["ikankecil"] = data["pendederan"]["ikankecil"] - len(temp)
		if file.open("res://storage/storage.json",File.WRITE) != 0:
			print("error opening file")
			return
		file.store_line(to_json(data))
		file.close()
	else:
		print('ada ikan mati belm dibersihin')
		print("belum ada ikan yg siap pindah")
		get_tree().change_scene("res://pembesaran_pool/Pembesaran.tscn")

func _on_FoodShop_pressed():
	var currMoney = Global.data.money - 18000
	
	if currMoney > 0:
		$Food/FoodBadge/FoodCount.text = str(Global.data.foodsA + 20)
		$Money/MoneyBadge/MoneyLabel.text = str(currMoney)
		var file = File.new()
		
		var data = Global.data
		data["foodsA"] = Global.data.foodsA + 20
		data["money"] = currMoney
		if file.open("res://storage/storage.json",File.WRITE) != 0:
			print("error opening file")
			return
		file.store_line(to_json(data))
		file.close()	
	else:
		print("money gak cukuyp")


func _on_Vit25_pressed():
	var currMoney = Global.data.money - 10000
	if currMoney > 0:
		$Vitamin/VitBadge/VitBadgeLabel.text = str(Global.data.vitaminA + Global.data.vitaminB + 1)
		get_node("ModalVitamins/25%/vit25badge/Label").text = str(Global.data.vitaminA+ 1) 
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
	else:
		print("money gk cukup")	


func _on_Vit50_pressed():
	var currMoney = Global.data.money - 20000
	
	if currMoney > 0:
		
		$Vitamin/VitBadge/VitBadgeLabel.text = str(Global.data.vitaminA + Global.data.vitaminB + 1)
		$Money/MoneyBadge/MoneyLabel.text = str(currMoney)
		get_node("ModalVitamins/50%/vit50badge/Label").text = str(Global.data.vitaminB+ 1) 
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


func _on_Clean_pressed():
	adddirt = false
	for x in $Kotoran.get_children():
		x.queue_free()
	adddirt = true
	


func _on_25_pressed():
	$ModalVitamins.hide()
	self.supplementButton = !self.supplementButton
	if(supplementButton):
		Global.supplementterbang = true
		get_node("Area2D").show()
	else:
		Global.supplementterbang = false
		get_node("Area2D").hide()
	


func _on_Button_pressed():
	get_tree().change_scene("res://main_menu/MainMenu.tscn")
