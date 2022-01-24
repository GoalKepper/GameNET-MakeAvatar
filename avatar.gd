extends Node2D

var nick:String = "Hi, dude" setget nick_set
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

func initialize (Nick, Area_radius, First_message_differ, Ghost, Messages, Randomize_messages, Run_frequency, Speed, Text_speed, color):
	nick_set(Nick)
	area_radius = Area_radius
	first_message_differ = First_message_differ
	ghost = Ghost
	messages = Messages
	randomize_messages = Randomize_messages
	run_frequency = Run_frequency
	speed = Speed
	text_speed = Text_speed
	modulate = color

func nick_set(Nick):
	nick = Nick
	$Node2D/Label.text = nick
