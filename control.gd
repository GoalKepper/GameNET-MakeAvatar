extends Control

var last_button: Button

func _ready():
	var json = Globals.json[Globals.avatar_id]
	$Panel2/Control/Avatar.initialize(json["nick"], json["area_radius"], json["first_message_differ"], json["ghost"], json["messages"].split('~'), json["randomize_messages"], json["run_frequency"], json["speed"], json["text_speed"], json["color"])
	$Panel/ScrollContainer/VBoxContainer/Nick/Nick_Button.text = $Panel2/Control/Avatar.nick
	for message in $Panel2/Control/Avatar.messages:
		_add_new_message(message)
	_add_new_message("")

func _on_Nick_Button_pressed():
	$Panel/ScrollContainer/VBoxContainer/Nick/Nick_Button.text = JavaScript.eval('prompt("%s", "%s");' % ['Введите что-либо', $Panel/ScrollContainer/VBoxContainer/Nick/Nick_Button.text])
	$Panel2/Control/Avatar.nick = $Panel/ScrollContainer/VBoxContainer/Nick/Nick_Button.text
	Globals.json[Globals.avatar_id]["nick"] = $Panel/ScrollContainer/VBoxContainer/Nick/Nick_Button.text

func _on_Color_Button_pressed():
	$ColorPicker.visible = !$ColorPicker.visible
	if $ColorPicker.visible:
		$Panel.anchor_right = 0.5
		$Panel2.anchor_right = 0.5
	else:
		$Panel.anchor_right = 1
		$Panel2.anchor_right = 1

func _on_ColorPicker_color_changed(color):
	$Panel2/Control/Avatar.modulate = color
	Globals.json[Globals.avatar_id]["color"] = $Panel2/Control/Avatar.modulate.to_html(false)
	print(Globals.json)

func _add_new_message(text: String):
	var button = Button.new()
	button.text = text
	last_button = button
	$Panel/ScrollContainer/VBoxContainer/Messages.add_child(button)
	button.connect("pressed", self, "_on_Message_pressed", [button])
	
func _on_Message_pressed(button:Button):
	var message_array:String = ""
	button.text = JavaScript.eval('prompt("%s", "%s");' % ['Введите что-либо', button.text])
	if (last_button.text != ""):
		_add_new_message("")
	if (button.text == "" and button != last_button):
		button.queue_free()
	for element in $Panel/ScrollContainer/VBoxContainer/Messages.get_children():
		if (element.text != ""):
			if (message_array == ""):
				message_array += element.text
			else:
				message_array += "~" + element.text
	Globals.json[Globals.avatar_id]["messages"] = message_array
	if message_array == "":
		OS.alert("Поздравляю! Ты нашел пасхалку. А теперь будь добр, введи хотя бы одно сообщение, иначе наш сайт накроется к чертям (:")

func _on_Save_Button_pressed():
	var json = JSON.print(Globals.json[Globals.avatar_id])
	$HTTPSet.request("https://gamenet-website-default-rtdb.europe-west1.firebasedatabase.app/Avatars/" + Globals.avatar_id + ".json", [ "Content-Length: "+ str(json.length()) ], false, HTTPClient.METHOD_PUT, json)

func _on_HTTPSet_request_completed(result, response_code, headers, body):
	if result == 0: 
		OS.alert("Все по кайфу")
	else:
		OS.alert("Чет не зашло")
