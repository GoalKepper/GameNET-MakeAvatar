extends KinematicBody2D

var nick:String = "ник"
export(Array, String, MULTILINE) var messages = ["привет"]
export var text_speed:float = 0.5
export var randomize_messages:bool = true
export var first_message_differ:bool = false
export var run_frequency:float = 0.01

export var speed:float = 25
export var area_radius:int = 100

export var ghost:bool = false


var message:String = " "  #текущие сообщение
var center = Vector2(0,0) #центр окружности патрулирования
var text_percent = 0      #скорость набора текста измеряется в процентах/кадр

var instruction = 0       #текущая инструкция
# 0 - стою на месте
# 1 - иду в какую-то точку

var target = Vector2()    #текщая точка назначения

var stop_ai = false       #тумблер отключения ИИ
var message_id = 0        #номер сообщения в списке messages

#проверка, было ли первое сообщение в списке messages показано
var check_for_first_message = false 

func instruction0_init():
	instruction = 0

func instruction1_init():
	instruction = 1

func _ready():
	center = position
	
	instruction1_init()

func _process(delta):
	$nickname.text = nick
	$message.text = message
	
	if not stop_ai:
		if instruction == 0:
			$AnimatedSprite.animation = "idle"
			if randf() < run_frequency:
				instruction1_init()
			
		if instruction == 1:
			$AnimatedSprite.animation = "walk"
	else:
		$AnimatedSprite.animation = "idle"
