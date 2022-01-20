extends Node2D

var nick:String = "Hi, dude"
var messages:Array = ["привет"]
var text_speed:float
var randomize_messages:bool
var first_message_differ:bool
var run_frequency:float

var speed:float
var area_radius:int

var ghost:bool

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func initialize (nick, area_radius, first_message_differ, ghost, messages, randomize_messages, run_frequency, speed, text_speed, color):
	nick = nick
	area_radius = area_radius
	first_message_differ = first_message_differ
	ghost = ghost
	messages = messages
	randomize_messages = randomize_messages
	run_frequency = run_frequency
	speed = speed
	text_speed = text_speed
	modulate = color
	# --------------------------------------- #
	$Node2D/Label.text = nick


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
