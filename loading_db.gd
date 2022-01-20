extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	$HTTPGet.request("https://gamenet-website-default-rtdb.europe-west1.firebasedatabase.app/Avatars.json")

func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	Globals.json = parse_json(body.get_string_from_utf8())
	get_tree().change_scene("res://Autorization.tscn")
