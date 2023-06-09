extends Node2D

signal return_to_lobby


onready var screen_size = get_viewport_rect().size

# firestore vars
var collection
var room_document_id = "qJixdfqPDNgVic8NOAp5"
var host_name

# room state
var playing = false
var game_time = 180
var letter = "A"
var cats = []

onready var game_timer = $UI/scroll_view/vbc/hbc/timer/game_timer

onready var orig_timer_style = $UI/scroll_view/vbc/hbc/timer.get("custom_styles/panel")
onready var active_timer_style = orig_timer_style.duplicate()

var bg_color
var fg_color
var border_color
var font_color

# theme colors: [0] is fg_color, [1] is font_color
var themes = [
	[Color("292929"), Color.white], 
	[Color("00203F"), Color("ADEFD1")],
	[Color("fb6f92").darkened(0.4), Color("ffc2d1")],
	[Color("343148"), Color("D7C49E")],
	
#	[Color("00B1D2").darkened(0.2), Color("FDDB27").lightened(0.4),],
	[Color("16697A"), Color("ffa62b").lightened(0.3)],
	[Color("89ABE3").darkened(0.2), Color("FCF6F5")],
	[Color("D198C5").darkened(0.4), Color("E0C568").lightened(0.2)],
	[Color("317773"), Color("E2D1F9").lightened(0.2)]
]

var change_theme_particles = preload("res://scenes/theme_change_particles.tscn")


func _ready():
	
	collection = Firebase.Firestore.collection('rooms')
	
	# THIS IS FOR iPHONES THAT HAVE THE CAMERA/SPEAKER
	# THAT EATS INTO THE TOP OF THE SCREEN
	var top_margin = $UI/scroll_view.margin_top
	$UI/scroll_view.margin_top = top_margin + 90
	
	# set timer and time_up dropdown offset like theme selector dropdown
	$UI/time_up_dropdown.offset = Vector2(0, -screen_size.y)
	
	initialize_theme_selector()
	# set default theme: black and white
	change_theme(themes[0][0], themes[0][1])
	
	var room_info = host_name + "'S ROOM (Guest)"
	$UI/scroll_view/vbc/room_info/text.set_text(room_info)

	initialize_category_numbers()

	
	# firestore: get/read room document
	# update game state and UI with it
	get_and_update_room()
	
	# start the polling loop
	$polling_update.start()


func get_and_update_room():
	
	collection.get(room_document_id)
	var room_doc = yield(collection, "get_document")
	
	# update letter, game_time, playing, cats
	var new_letter = room_doc.doc_fields["letter"]
	var new_game_time = room_doc.doc_fields["game_time"]
	var new_playing = room_doc.doc_fields["playing"]
	var new_cats = room_doc.doc_fields["cats"]
	
	# update letter
	letter = new_letter
	$UI/scroll_view/vbc/hbc/letter/vbc/text.set_text(letter)
	# update game time
	game_time = new_game_time
	if not playing:
		$UI/scroll_view/vbc/hbc/timer/vbc/text.set_text(str(game_time))
	# update cats
	cats = new_cats
	var i = 0
	for cat in $UI/scroll_view/vbc/categories/vbc.get_children():
		cat.get_node("text").set_text(cats[i])
		i += 1
	
	# update playing
	if playing != new_playing:
		if new_playing:  # the timer was just started
			
			playing = true
			# start game timer
			game_timer.start(game_time)
			# adjust timer theme
			$UI/scroll_view/vbc/hbc/timer/vbc.modulate = Color.white
			$UI/scroll_view/vbc/hbc/timer.set("custom_styles/panel", active_timer_style)
			
		else:  # the timer was just stopped
			
			# IF 3 OR LESS SECONDS LEFT: IGNORE AND LET TIMEOUT HANDLE IT
			if game_timer.time_left < 3.0:
				return
			
			playing = false
			# reset game timer
			game_timer.stop()
			$UI/scroll_view/vbc/hbc/timer/vbc/text.set_text(str(game_time))
			# restore timer theme
			$UI/scroll_view/vbc/hbc/timer.set("custom_styles/panel", orig_timer_style)
			$UI/scroll_view/vbc/hbc/timer/vbc.modulate = font_color


func adjust_right_margin():
	var margin_no_bar = -24
	var margin_with_bar = -14
	var scroll_view_size = $UI/scroll_view.rect_size.y
	var content_size = $UI/scroll_view/vbc.rect_size.y
	# condition: if content_size > view size
	if content_size > scroll_view_size:
		$UI/scroll_view.margin_right = margin_with_bar
	else:
		$UI/scroll_view.margin_right = margin_no_bar
	
func initialize_category_numbers():
	var i = 1
	for cat in $UI/scroll_view/vbc/categories/vbc.get_children():
		var num = cat.get_node("number")
		num.set_text(str(i))
		i += 1

func change_theme(fg : Color, font : Color, tween=false):
	
	# set global color vars
	bg_color = fg.darkened(0.4)
	fg_color = fg
	border_color = fg.lightened(0.2)
	font_color = font
	
	$UI/scroll_view/vbc/room_info/text.modulate = font
	$UI/scroll_view/vbc/hbc/letter/vbc.modulate = font
	if not playing:
		$UI/scroll_view/vbc/hbc/timer/vbc.modulate = font
	$UI/scroll_view/vbc/categories/vbc.modulate = font
	$UI/scroll_view/vbc/change_theme/hbc.modulate = font
	$UI/scroll_view/vbc/return_to_lobby/hbc.modulate = font
	
	# background
	$UI/background.color = bg_color
	
	# borderless
	var borderless_style = $UI/scroll_view/vbc/room_info.get("custom_styles/panel")
	borderless_style.bg_color = fg_color
	
	# bordered
	var bordered_style = $UI/scroll_view/vbc/change_theme.get("custom_styles/panel")
	bordered_style.bg_color = fg_color
	bordered_style.border_color = border_color
	
	# active_timer style
	active_timer_style.bg_color = border_color
	active_timer_style.border_color = border_color


func initialize_theme_selector():
	
	$UI/dropdown.offset = Vector2(0, -screen_size.y)
	
	var font_style = $UI/dropdown/theme_selector/vbc/row_1/theme_1/font.get("custom_styles/panel")
	var fg_style = $UI/dropdown/theme_selector/vbc/row_1/theme_1/fg.get("custom_styles/panel")
	
	var i = 0
	for row in $UI/dropdown/theme_selector/vbc.get_children().slice(1, 2):
		for theme in row.get_children():
			var temp_style = fg_style.duplicate()
			temp_style.bg_color = themes[i][0]
			theme.get_node("fg").set("custom_styles/panel", temp_style)
			
			temp_style = font_style.duplicate()
			temp_style.bg_color = themes[i][1]
			theme.get_node("font").set("custom_styles/panel", temp_style)
			
			i += 1


var orig_style = null

# a button is pressed
func swap_button_style(panel):
	orig_style = panel.get("custom_styles/panel")
	var temp_style = orig_style.duplicate()
	temp_style.bg_color = border_color
	panel.set("custom_styles/panel", temp_style)

# a button is released
func restore_button_style(panel):
	panel.set("custom_styles/panel", orig_style)


var dropdown_onscreen = Vector2(0, 0)
onready var dropdown_offscreen = Vector2(0, -screen_size.y)
var haze_active = Color(0, 0, 0, 0.6)
var haze_inactive = Color(0, 0, 0, 0)

func _on_theme_button_button_down():
	swap_button_style($UI/scroll_view/vbc/change_theme)

func _on_theme_button_button_up():
	restore_button_style($UI/scroll_view/vbc/change_theme)

func _on_theme_button_pressed():
	$audio/button_push.play()
	
	$UI/haze.visible = true
	var tween = $UI/dropdown/dropdown_tween
	tween.interpolate_property($UI/haze, "color", haze_inactive, haze_active, .2, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	tween.interpolate_property($UI/dropdown, "offset", dropdown_offscreen, dropdown_onscreen, .6, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	tween.start()

func _on_theme_selected(theme_id):

	$audio/change_theme.play()
	
	# call change_theme with tween=true?
	change_theme(themes[theme_id][0], themes[theme_id][1])
	
	var tween = $UI/dropdown/dropdown_tween
	tween.interpolate_property($UI/haze, "color", haze_active, haze_inactive, .2, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	tween.interpolate_property($UI/dropdown, "offset", dropdown_onscreen, dropdown_offscreen, .6, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	tween.start()
	
	var particles = change_theme_particles.instance()
	particles.modulate = font_color
	$UI/particles_container/particle_pos.add_child(particles)
	
	yield(get_tree().create_timer(.2), "timeout")
	$UI/haze.visible = false



func _on_game_timer_timeout():
	
	playing = false
	
	# reset game timer
	game_timer.stop()
	$UI/scroll_view/vbc/hbc/timer/vbc/text.set_text(str(game_time))
	# restore timer theme
	$UI/scroll_view/vbc/hbc/timer.set("custom_styles/panel", orig_timer_style)
	$UI/scroll_view/vbc/hbc/timer/vbc.modulate = font_color
	
	# if the change theme menu is up, don't show the time up message
	if $UI/haze.visible:
		return
	
	$UI/time_up_dropdown/panel/text/anim.play("idle")
	$UI/haze.visible = true
	var tween = $UI/time_up_dropdown/dropdown_tween
	tween.interpolate_property($UI/haze, "color", haze_inactive, haze_active, .2, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	tween.interpolate_property($UI/time_up_dropdown, "offset", dropdown_offscreen, dropdown_onscreen, .6, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	tween.start()
	
	$audio/time_up.play()
	yield(get_tree().create_timer(3), "timeout")
	
	tween.interpolate_property($UI/haze, "color", haze_active, haze_inactive, .2, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	tween.interpolate_property($UI/time_up_dropdown, "offset", dropdown_onscreen, dropdown_offscreen, .6, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	tween.start()
	
	yield(get_tree().create_timer(.2), "timeout")
	$UI/haze.visible = false
	$UI/time_up_dropdown/panel/text/anim.stop()



func _on_polling_update_timeout():
	
	get_and_update_room()
	$polling_update.start()



func _on_lobby_button_button_down():
	swap_button_style($UI/scroll_view/vbc/return_to_lobby)

func _on_lobby_button_button_up():
	restore_button_style($UI/scroll_view/vbc/return_to_lobby)

func _on_lobby_button_pressed():
	
	$UI/haze.visible = true
	$audio/button_push.play()
	emit_signal("return_to_lobby")
	


