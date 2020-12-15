extends KinematicBody2D
var status = randomize()
var progressVal = 100
var hungryVal = 0
var motion = Vector2()
var jmlmakan = 0
var readymove = false
func _ready():
	$AnimatedSprite.play("swim")
	$AnimatedSprite/FeedIndicator.hide()
	
func _process(delta):
	progressVal = progressVal - 0.01
	$AnimatedSprite/Lifetime.value = progressVal
	
	if hungryVal > 10:
		$AnimatedSprite/FeedIndicator.show()
	else:
		$AnimatedSprite/FeedIndicator.hide()
		hungryVal = hungryVal + 0.01
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
		
func _physics_process(delta):
	
	
	if position.x > 600.0:
		#$AnimatedSprite.rotation_degrees = 180
		pass
	else:
		motion.x= 20
		global_position += motion * delta



func _on_Button_pressed():
	if Global.pakanterbang and hungryVal > 10:
		self.hungryVal = 0
		self.jmlmakan = self.jmlmakan+1
		if self.jmlmakan == 3:
			self.scale = Vector2(3.0,3.0)
			$AnimatedSprite/MovePoolIndicator.show()
			readymove = true
		
		get_node("/root/Pendederan/Food/FoodBadge/FoodCount").text = str(Global.data.foodsA - 1)
		
		
		var file = File.new()
		
		var data = Global.data
		data["foodsA"] = Global.data.foodsA - 1
		if file.open("res://storage/storage.json",File.WRITE) != 0:
			print("error opening file")
			return
		file.store_line(to_json(data))
		file.close()	
	
