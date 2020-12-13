extends Control

var leleNode = preload("res://lele/Lele.tscn")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Money/Money/MoneyLabel.text = str(Global.data.money)
	var fishes = Global.data["pembesaran"]["ikanbesar"] + Global.data["pembesaran"]["ikankecil"]
	print(fishes)
	for x in range(fishes):
		var parent = get_node("Pool")
		var lele = leleNode.instance()
		lele.position = Vector2(195+randi()%200+5,310+randi()%200+5)
		lele.z_index = 0	
		lele.scale.x = 2.0
		lele.scale.y = 2.0
		parent.add_child(lele)


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


func _on_MovePool_pressed():
	get_tree().change_scene("res://UI/Pendederan.tscn")


func _on_Food2_pressed():
	var currMoney = Global.data.money - 18000
	$Food/FoodBadge/FoodBadgeLabel.text = str(Global.data.foodsB + 1)
	$Money/Money/MoneyLabel.text = str(currMoney)
	var file = File.new()
	
	var data = Global.data
	data["foodsB"] = Global.data.foodsB + 1
	data["money"] = currMoney
	if file.open("res://storage/storage.json",File.WRITE) != 0:
		print("error opening file")
		return
	file.store_line(to_json(data))
	file.close()	
