extends Control

var nick:String
var password:String

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	#nick = JavaScript.eval('prompt("%s", "%s");' % ['Введите ник', ""])
	#password = JavaScript.eval('prompt("%s", "%s");' % ['Введите пароль', ""])
	nick = "night_glider"
	password = "admin"
	for element in Globals.json:
		if Globals.json[element]["nick"] == nick and Globals.json[element]["password"] == password:
			Globals.avatar_id = element
			get_tree().change_scene("res://Control.tscn")
			break
	if Globals.avatar_id == "":
		OS.alert("Введенные данные неверны!")
