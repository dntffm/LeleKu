extends Node
var profileDialogPopUp
var dismissDialog
func _ready():
	profileDialogPopUp = get_node("Popup")
	dismissDialog = get_node("Popup/ColorRect/Button")
	pass
	
func load_data():
	var file = File.new()
	
	if not file.file_exists("res://storage/storage.json"):
		print("No data")
		return
	if file.open("res://storage/storage.json",File.READ) != 0:
		print("error opening file")
		return
	var data = parse_json(file.get_line())
	return data
	
func _on_Button_pressed():
	var lineEditText = get_node("LineEdit").text
	if(lineEditText == ""):
		profileDialogPopUp.show()
		pass
	else:
		var file = File.new()
		
		var data = {
			"username" : lineEditText,
			"money" : 100000,
			"pendederan" : {
				"ikankecil" : 0,
				"ikanbesar" : 0
			},
			"pembesaran" : {
				"ikankecil" : 0,
				"ikanbesar" : 0
			}
		}
		
		if file.open("res://storage/storage.json",File.WRITE) != 0:
			profileDialogPopUp.show()
			return
		file.store_line(to_json(data))
		file.close()		
		
		Global.data = load_data()
		
		get_tree().change_scene("res://main_menu/MainMenu.tscn")
func _on_Dismiss_Button_pressed():
	profileDialogPopUp.hide()
	pass # Replace with function body.
