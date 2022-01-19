extends KinematicBody2D

export var nick:String = "Nick"
export var message:String = " "  #текущее сообщение
export var text_speed:float = 0.5
export var randomize_messages:bool = true
export var first_message_differ:bool = false
export var run_frequency:float = 0.01
export var is_walking:bool = false

export var speed:float = 25
export var area_radius:int = 100

var text_percent = 0      #скорость набора текста измеряется в процентах/кадр
var message_id = 0        #номер сообщения в списке messages

#проверка, было ли первое сообщение в списке messages показано
var check_for_first_message = false 

func _ready():
	$AnimatedSprite.animation = "idle"

func _process(delta):
	$nickname.text = nick
	$message.text = message
	$NinePatchRect.rect_position = $message.rect_position
	$NinePatchRect.rect_position.x -= 9
	$NinePatchRect.rect_position.y -= 3
	$NinePatchRect.rect_size = $message.rect_size
	$NinePatchRect.rect_size.x += 20
	$message.percent_visible+=text_percent
	$NinePatchRect.visible = true
	$message.visible = true
	
	if is_walking == true:
		$AnimatedSprite.animation = "walk"
	else:
		$AnimatedSprite.animation = "idle"
