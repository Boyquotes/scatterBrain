extends Panel

onready var game_timer = $game_timer
onready var timer_display = $vbc/text

func _ready():
	pass

func _physics_process(_delta):
	if not game_timer.is_stopped():
		var time_left = game_timer.get_time_left()
		time_left = str(round(time_left))
		timer_display.set_text(time_left)
		
