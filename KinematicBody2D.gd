extends KinematicBody2D
var status = randomize()
var progressVal = 100
var hungryVal = 0
var lelehidup = true
var motion = Vector2()
var jmlmakan = 0
var jmlmakanB = 0
var readymove = false
var readySell = false
var feedAble = true
func _ready():
	$AnimatedSprite.play("swim")
	$AnimatedSprite/FeedIndicator.hide()
	
func _process(delta):
	if lelehidup:
		progressVal = progressVal - 0.05
		$AnimatedSprite/Lifetime.value = progressVal
		
		
		if hungryVal > 10:
			$AnimatedSprite/FeedIndicator.show()
		else:
			$AnimatedSprite/FeedIndicator.hide()
			hungryVal = hungryVal + 0.05
			
		if progressVal > 50:
			$AnimatedSprite/Lifetime.show()
			$AnimatedSprite/Lifetime2.hide()
			$AnimatedSprite/Lifetime3.hide()
		elif progressVal > 25:
			$AnimatedSprite/Lifetime.hide()
			$AnimatedSprite/Lifetime2.show()
			$AnimatedSprite/Lifetime3.hide()
		else:
			$AnimatedSprite/Lifetime.hide()
			$AnimatedSprite/Lifetime2.hide()
			$AnimatedSprite/Lifetime3.show()
			var par = get_parent().name
			
			if par == 'Grass':
				get_node('/root/Pendederan/Pool/HBoxContainer').remove_child(get_node('/root/Pendederan/Pool/HBoxContainer').get_children()[Global.playerhealth - 1])
				if get_node('/root/Pendederan/Pool/HBoxContainer').get_child_count() == 0:
					get_node('/root/Pendederan/GameOver/coin/Label').text = str(Global.jumlahpanen * 5000)
					get_node('/root/Pendederan/GameOver/fish/Label').text = str(Global.jumlahpanen)
					get_node('/root/Pendederan/GameOver').show()
			else:
				get_parent().get_parent().get_node("Pool/HBoxContainer").remove_child(get_parent().get_parent().get_node("Pool/HBoxContainer").get_children()[Global.playerhealth - 1])
				if get_parent().get_parent().get_node("Pool/HBoxContainer").get_child_count() == 0:
					get_parent().get_parent().get_node('GameOverDialog/fish/Label').text = str(Global.jumlahpanen)
					get_parent().get_parent().get_node('GameOverDialog/gameovercoin/gameoverlabel').text = str(Global.jumlahpanen * 5000)
					get_parent().get_parent().get_node('GameOverDialog').show()
			Global.playerhealth = Global.playerhealth - 1
			self.lelehidup = false
	else:
		$AnimatedSprite/DieIndicator.show()
	
func _physics_process(delta):
	
	
	if position.x > 600.0:
		#$AnimatedSprite.rotation_degrees = 180
		pass
	else:
		motion.x= 20
		global_position += motion * delta



func _on_Button_pressed():
	print(get_parent().get_parent().get_node(''))
	var par = get_parent().name
	print(jmlmakanB)
	if !lelehidup:
		Global.jumlahikanmati = Global.jumlahikanmati + 1
		if par == 'Grass':
			get_node('/root/Pendederan/Trash/FoodBadge2/FoodCount').text = str(Global.jumlahikanmati)
		else:
			get_parent().get_parent().get_node('Trash/FoodBadge2/FoodBadgeLabel').text = str(Global.jumlahikanmati)
		self.queue_free()
	if readySell:
		Global.data.money = Global.data.money + 5000
		Global.jumlahpanen = Global.jumlahpanen + 1
		if par == 'Grass':
			get_node("/root/Pendederan/Money/MoneyBadge/MoneyLabel").text = str(Global.data.money)
		else:
			get_parent().get_parent().get_node("Money/Money/MoneyLabel").text = str(Global.data.money)
	if Global.pakanterbang and hungryVal > 10 and feedAble:
		self.hungryVal = 0
		
		
		var file = File.new()
		
		var data = Global.data
		if par == "Grass":
			self.jmlmakan = self.jmlmakan+1	
			get_node("/root/Pendederan/Food/FoodBadge/FoodCount").text = str(Global.data.foodsA - 1)
			data["foodsA"] = Global.data.foodsA - 1
			if self.jmlmakan == 3:
				self.feedAble = false
				self.scale = Vector2(3.0,3.0)
				$AnimatedSprite/MovePoolIndicator.show()
				readymove = true
		else:
			self.feedAble = true
			self.jmlmakanB = self.jmlmakanB + 1
			get_parent().get_parent().get_node('Food/FoodBadge/FoodBadgeLabel').text = str(Global.data.foodsB - 1)
			#get_node("res://pembesaran_pool/Pembesaran/Food/FoodBadge/FoodBadgeLabel").text = str(Global.data.foodsB - 1)
			data["foodsB"] = Global.data.foodsB - 1			
			if self.jmlmakanB == 5:
				self.feedAble = false
				self.scale = Vector2(3.0,3.0)
				$AnimatedSprite/PanenIndicator.show()
				readySell = true
		if file.open("res://storage/storage.json",File.WRITE) != 0:
			print("error opening file")
			return
		file.store_line(to_json(data))
		file.close()
		
	if Global.supplementterbang:
		self.progressVal = self.progressVal + 75	
	
