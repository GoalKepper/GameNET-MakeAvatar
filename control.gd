extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _ready():
	var json = Globals.json[Globals.avatar_id]
	$Panel2/Control/Avatar.initialize(json["nick"], json["area_radius"], json["first_message_differ"], json["ghost"], json["messages"].split('~'), json["randomize_messages"], json["run_frequency"], json["speed"], json["text_speed"], json["color"])

func _on_Button_pressed():
	$Panel/ScrollContainer/VBoxContainer/Button.text = JavaScript.eval('prompt("%s", "%s");' % ['Введите что-либо', $Panel/ScrollContainer/VBoxContainer/Button.text])
