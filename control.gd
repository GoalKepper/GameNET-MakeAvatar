extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func _ready():
	$HTTPGet.request("https://gamenet-website-default-rtdb.europe-west1.firebasedatabase.app/Avatars/avatar0.json")

func _on_Button_pressed():
	$Panel/ScrollContainer/VBoxContainer/Button.text = JavaScript.eval('prompt("%s", "%s");' % ['Введите что-либо', $Panel/ScrollContainer/VBoxContainer/Button.text])

func _on_HTTPGet_request_completed(result, response_code, headers, body):
	var json = parse_json(body.get_string_from_utf8())
	$Panel2/Control/Avatar.initialize(json["nick"], json["area_radius"], json["first_message_differ"], json["ghost"], json["messages"].split('~'), json["randomize_messages"], json["run_frequency"], json["speed"], json["text_speed"], json["color"])
