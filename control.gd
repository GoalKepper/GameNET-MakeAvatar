extends Control

var last_button: Button

func _ready():
	var json = Globals.json[Globals.avatar_id]
	$Panel2/Control/Avatar.initialize(json["nick"], json["area_radius"], json["first_message_differ"], json["ghost"], json["messages"].split('~'), json["randomize_messages"], json["run_frequency"], json["speed"], json["text_speed"], json["color"])
	$Panel/ScrollContainer/VBoxContainer/Nick/Nick_Button.text = $Panel2/Control/Avatar.nick
	$Panel/ScrollContainer/VBoxContainer/Nick/Pwd_Button.text = Globals.json[Globals.avatar_id]["password"]
	$Panel/ScrollContainer/VBoxContainer/Speed/Speed_Button.text = str($Panel2/Control/Avatar.speed)
	$Panel/ScrollContainer/VBoxContainer/Speed/Area_Button.text = str($Panel2/Control/Avatar.area_radius)
	$Panel/ScrollContainer/VBoxContainer/Run_Freq/Run_Button.text = str($Panel2/Control/Avatar.run_frequency)
	if ($Panel2/Control/Avatar.first_message_differ):
		$Panel/ScrollContainer/VBoxContainer/FMD/FMD_Button.text = "Да"
	else:
		$Panel/ScrollContainer/VBoxContainer/FMD/FMD_Button.text = "Нет"
	if ($Panel2/Control/Avatar.randomize_messages):
		$Panel/ScrollContainer/VBoxContainer/Rand_Mess/Rand_Mess_Button.text = "Да"
	else:
		$Panel/ScrollContainer/VBoxContainer/Rand_Mess/Rand_Mess_Button.text = "Нет"
	for message in $Panel2/Control/Avatar.messages:
		_add_new_message(message)
	_add_new_message("+")

func _on_Nick_Button_pressed():
	$Panel/ScrollContainer/VBoxContainer/Nick/Nick_Button.text = JavaScript.eval('prompt("%s", "%s");' % ['Введите что-либо', $Panel/ScrollContainer/VBoxContainer/Nick/Nick_Button.text])
	$Panel2/Control/Avatar.nick = $Panel/ScrollContainer/VBoxContainer/Nick/Nick_Button.text
	Globals.json[Globals.avatar_id]["nick"] = $Panel/ScrollContainer/VBoxContainer/Nick/Nick_Button.text
	
func _on_Pwd_Button_pressed():
	$Panel/ScrollContainer/VBoxContainer/Nick/Pwd_Button.text = JavaScript.eval('prompt("%s", "%s");' % ['Введите что-либо', $Panel/ScrollContainer/VBoxContainer/Nick/Pwd_Button.text])
	Globals.json[Globals.avatar_id]["password"] = $Panel/ScrollContainer/VBoxContainer/Nick/Pwd_Button.text

func _on_Speed_Button_pressed():
	$Panel/ScrollContainer/VBoxContainer/Speed/Speed_Button.text = JavaScript.eval('prompt("%s", "%s");' % ['Введите скорость', $Panel2/Control/Avatar.speed])
	var set_speed:float = float($Panel/ScrollContainer/VBoxContainer/Speed/Speed_Button.text)
	if set_speed > 100:
		OS.alert("Развить скорость кометы? Интересная мысль, но лучше остановимся на 100")
		set_speed = 100
	if set_speed < 0:
		OS.alert("Где вы видели отрицательную скорость? Все, что можем предложить - стоять на месте :D")
		set_speed = 0
	$Panel2/Control/Avatar.speed = set_speed
	$Panel/ScrollContainer/VBoxContainer/Speed/Speed_Button.text = str(set_speed)
	Globals.json[Globals.avatar_id]["speed"] = set_speed
	
func _on_Area_Button_pressed():
	$Panel/ScrollContainer/VBoxContainer/Speed/Area_Button.text = JavaScript.eval('prompt("%s", "%s");' % ['Введите радиус', $Panel2/Control/Avatar.area_radius])
	var set_radius:int = int($Panel/ScrollContainer/VBoxContainer/Speed/Area_Button.text)
	if set_radius > 100:
		OS.alert("Ого, исследования могут зайти слишком далеко! Ограничимся радиусом около 100, хорошо?")
		set_radius = 100
	if set_radius < 0:
		OS.alert("Отрицательные координаты... Неужели вы исследуете мнимую плоскость? Сайт упадет, лучше не надо :3\n\nP.S. А радиус вернем к 0")
		set_radius = 0
	$Panel2/Control/Avatar.area_radius = set_radius
	$Panel/ScrollContainer/VBoxContainer/Speed/Area_Button.text = str(set_radius)
	Globals.json[Globals.avatar_id]["area_radius"] = set_radius

func _on_Run_Button_pressed():
	$Panel/ScrollContainer/VBoxContainer/Run_Freq/Run_Button.text = JavaScript.eval('prompt("%s", "%s");' % ['Введите вероятность', $Panel2/Control/Avatar.run_frequency])
	var set_run:float = float($Panel/ScrollContainer/VBoxContainer/Run_Freq/Run_Button.text)
	if set_run > 1:
		OS.alert("Вероятность не может быть больше 1... Жаль, но таков закон")
		set_run = 1
	if set_run < 0:
		OS.alert("Вы настолько не хотите ходить, что вероятность вашего движения меньше 0? Сильно... но нуля будет достаточно :3")
		set_run = 0
	$Panel2/Control/Avatar.run_frequency = set_run
	$Panel/ScrollContainer/VBoxContainer/Run_Freq/Run_Button.text = str(set_run)
	Globals.json[Globals.avatar_id]["run_frequency"] = set_run

func _on_FMD_Button_pressed():
	$Panel2/Control/Avatar.first_message_differ = !$Panel2/Control/Avatar.first_message_differ
	if ($Panel2/Control/Avatar.first_message_differ):
		$Panel/ScrollContainer/VBoxContainer/FMD/FMD_Button.text = "Да"
	else:
		$Panel/ScrollContainer/VBoxContainer/FMD/FMD_Button.text = "Нет"
	Globals.json[Globals.avatar_id]["first_message_differ"] = $Panel2/Control/Avatar.first_message_differ
	
func _on_Rand_Mess_Button_pressed():
	$Panel2/Control/Avatar.randomize_messages = !$Panel2/Control/Avatar.randomize_messages
	if ($Panel2/Control/Avatar.randomize_messages):
		$Panel/ScrollContainer/VBoxContainer/Rand_Mess/Rand_Mess_Button.text = "Да"
	else:
		$Panel/ScrollContainer/VBoxContainer/Rand_Mess/Rand_Mess_Button.text = "Нет"
	Globals.json[Globals.avatar_id]["randomize_messages"] = $Panel2/Control/Avatar.randomize_messages

func _on_Color_Button_pressed():
	$ColorPicker.visible = !$ColorPicker.visible
	if $ColorPicker.visible:
		$Panel/ScrollContainer/VBoxContainer/Color/Color_Button.text = "Свернуть"
		$Panel.anchor_right = 0.5
		$Panel2.anchor_right = 0.5
	else:
		$Panel/ScrollContainer/VBoxContainer/Color/Color_Button.text = "Открыть"
		$Panel.anchor_right = 1
		$Panel2.anchor_right = 1

func _on_ColorPicker_color_changed(color):
	if color == Color("#25252a"):
		OS.alert("Видимо, среди нас шпион... Впрочем, на карте персонажа все равно будет видно, но за находчивость мое почтение :D")
	$Panel2/Control/Avatar.modulate = color
	Globals.json[Globals.avatar_id]["color"] = $Panel2/Control/Avatar.modulate.to_html(false)

func _add_new_message(text: String):
	var button = Button.new()
	button.text = text
	last_button = button
	$Panel/ScrollContainer/VBoxContainer/Messages.add_child(button)
	button.connect("pressed", self, "_on_Message_pressed", [button])
	
func _on_Message_pressed(button:Button):
	var message_array:String = ""
	button.text = JavaScript.eval('prompt("%s", "%s");' % ['Введите что-либо', button.text])
	if (last_button.text != "+"):
		_add_new_message("+")
	if (button.text == "" and button != last_button):
		button.queue_free()
	for element in $Panel/ScrollContainer/VBoxContainer/Messages.get_children():
		if (element.text != "+"):
			if (message_array == ""):
				message_array += element.text
			else:
				message_array += "~" + element.text
	if message_array == "":
		OS.alert("Поздравляю! Ты нашел пасхалку. А теперь будь добр, введи хотя бы одно сообщение, иначе наш сайт накроется к чертям (:")
		last_button.text = "Введи текст, пж"
		message_array = "Я просто промолчу"
	Globals.json[Globals.avatar_id]["messages"] = message_array

func _on_Save_Button_pressed():
	var json = JSON.print(Globals.json[Globals.avatar_id])
	$HTTPSet.request("https://gamenet-website-default-rtdb.europe-west1.firebasedatabase.app/Avatars/" + Globals.avatar_id + ".json", [ "Content-Length: "+ str(json.length()) ], false, HTTPClient.METHOD_PUT, json)

func _on_HTTPSet_request_completed(result, response_code, headers, body):
	if result == 0: 
		OS.alert("Все по кайфу")
	else:
		OS.alert("Мистер Старк, мне что-то нехорошо...")
