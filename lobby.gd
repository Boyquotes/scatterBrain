extends Node2D

signal begin_hosting
signal join_host


onready var keyboard_key = preload("res://scenes/keyboard_key.tscn")
onready var join_room_button = preload("res://scenes/join_room.tscn")

onready var name_field = $create_room/vbc/name_field/text

var screen_height

var on_screen
var above_screen
var below_screen

var transition_duration = 0.4
var transition_method = Tween.TRANS_EXPO
var easing = Tween.EASE_OUT

var accept_input = true
var room_refresh_in_progress = false

# firestore vars
var room_collection


func _ready():
	
	# set screen size vars
	screen_height = $UI/background.rect_size.y
	$create_room.offset = Vector2(0, screen_height)
	$UI.offset = Vector2(0, screen_height)
	
	# THIS IS FOR iPHONES THAT HAVE THE CAMERA/SPEAKER
	# THAT EATS INTO THE TOP OF THE SCREEN
	var top_margin = $UI/vbc.margin_top
	$UI/vbc.margin_top = top_margin + 90
	
	on_screen = Vector2(0, 0)
	above_screen = Vector2(0, -screen_height)
	below_screen = Vector2(0, screen_height)
	
	initialize_keyboard()
	$UI/vbc/refresh/CenterContainer/Control/penguin/swing_particles.emitting = true 
	
	# connect to firestore
	room_collection = Firebase.Firestore.collection('rooms')
	get_room_list()
	
	# make UI visible (give time to load rooms from firestore)
	yield(get_tree().create_timer(1.5), "timeout")
	var tween = $transition_tween
	tween.interpolate_property($UI, "offset", below_screen, on_screen, 0.8, transition_method, easing)
	tween.start()


func get_room_list():
	
	room_refresh_in_progress = true
	
	# clear previous rooms
	var room_container = $UI/vbc/scroll_view/vbc/room_list
	for old_room in room_container.get_children():
		old_room.queue_free()
	
	# create a query
	var query = FirestoreQuery.new()
	query.from("rooms")
	query.where("playing", FirestoreQuery.OPERATOR.EQUAL, false)

	var query_task = Firebase.Firestore.query(query)
	var result : Array = yield(query_task, "result_query")

	# add results as join_room buttons
	for room_data in result:
		# if room is new, create a new button with the room link
		if is_new_room(room_data):
			var new_join_room_button = join_room_button.instance()
			new_join_room_button.host_name = room_data.doc_fields["host"]
			new_join_room_button.room_id = room_data.doc_name
			new_join_room_button.connect("join_host", self, "connect_to_host")
			room_container.add_child(new_join_room_button)
		else:
			delete_old_room(room_data)
	
	room_refresh_in_progress = false

# checks if a room was created < 3 hrs ago
func is_new_room(room_data):
	
	var room_timestamp = room_data.doc_fields["timestamp"]
	var current_unix_time = OS.get_unix_time()
	var time_elapsed = current_unix_time - room_timestamp
	var hours_elapsed = time_elapsed / 3600
	
	return hours_elapsed < 3

func delete_old_room(room_data):
	var del_task = room_collection.delete(room_data.doc_name)
	yield(del_task, "task_finished")


var orig_style = null

# a button is pressed
func swap_button_style(panel):
	orig_style = panel.get("custom_styles/panel")
	var temp_style = orig_style.duplicate()
	temp_style.bg_color = Color.white
	panel.set("custom_styles/panel", temp_style)

# a button is released
func restore_button_style(panel):
	panel.set("custom_styles/panel", orig_style)


func _on_refresh_rooms_button_down():
	swap_button_style($UI/vbc/refresh/Panel)
	$UI/vbc/refresh/Panel/Control/icon.modulate = orig_style.bg_color

func _on_refresh_rooms_button_up():
	restore_button_style($UI/vbc/refresh/Panel)
	$UI/vbc/refresh/Panel/Control/icon.modulate = Color.white
	
func _on_refresh_rooms_pressed():
	
	if not accept_input:
		return
	$audio/refresh.play()
	
	var icon = $UI/vbc/refresh/Panel/Control/icon
	$UI/vbc/refresh/CenterContainer/Control/penguin.do_refresh_spin(icon)
	if not room_refresh_in_progress:
		get_room_list()


func _on_create_room_button_down():
	swap_button_style($UI/vbc/scroll_view/vbc/create)
	$UI/vbc/scroll_view/vbc/create/text.modulate = orig_style.bg_color

func _on_create_room_button_up():
	restore_button_style($UI/vbc/scroll_view/vbc/create)
	$UI/vbc/scroll_view/vbc/create/text.modulate = Color.white

func _on_create_room_pressed():
	
	if not accept_input:
		return
	$audio/button_push.play()
	
	var tween = $transition_tween
	tween.interpolate_property($UI, "offset", on_screen, above_screen, transition_duration, transition_method, easing)
	tween.interpolate_property($create_room, "offset", below_screen, on_screen, transition_duration, transition_method, easing)
	tween.start()
	

func initialize_keyboard():
	
	var keys = "QWERTYUIOPASDFGHJKLZXCVBNM"
	var i = 0
	
	for key in $create_room/keyboard/row_1.get_children():
		key.set_letter(keys[i])
		key.connect("key_typed", self, "key_typed")
		i += 1
	for key in $create_room/keyboard/row_2.get_children().slice(1, -2):
		key.set_letter(keys[i])
		key.connect("key_typed", self, "key_typed")
		i += 1
	for key in $create_room/keyboard/row_3.get_children().slice(1, -2):
		key.set_letter(keys[i])
		key.connect("key_typed", self, "key_typed")
		i += 1
	$create_room/keyboard/row_4/space_key.connect("key_typed", self, "key_typed")
	$create_room/keyboard/row_4/delete_key.connect("delete_key", self, "delete_key_typed")

func key_typed(letter):
	
	var current_text = name_field.get_text()
	if current_text.length() < 10:
		name_field.set_text(current_text + letter)
		$audio/keyboard_hit.play()

func delete_key_typed():
	
	var current_text = name_field.get_text()
	if current_text.length() > 0:
		name_field.set_text(current_text.substr(0, current_text.length() - 1))
		$audio/keyboard_hit.play()


func _on_cancel_create_button_down():
	swap_button_style($create_room/vbc/cancel)
	$create_room/vbc/cancel/text.modulate = orig_style.bg_color

func _on_cancel_create_button_up():
	restore_button_style($create_room/vbc/cancel)
	$create_room/vbc/cancel/text.modulate = Color.white

func _on_cancel_create_pressed():
	
	if not accept_input:
		return
	$audio/button_push.play()
	
	var tween = $transition_tween
	tween.interpolate_property($UI, "offset", above_screen, on_screen, transition_duration, transition_method, easing)
	tween.interpolate_property($create_room, "offset", on_screen, below_screen, transition_duration, transition_method, easing)
	tween.start()
	
	name_field.set_text("")


func _on_begin_game_button_down():
	swap_button_style($create_room/vbc/play)
	$create_room/vbc/play/text.modulate = orig_style.bg_color

func _on_begin_game_button_up():
	restore_button_style($create_room/vbc/play)
	$create_room/vbc/play/text.modulate = Color.white

func _on_begin_game_pressed():
	
	var current_name = name_field.get_text()
	if current_name.length() < 1 or not_valid_name(current_name):
		return
	
	accept_input = false
	$audio/button_push.play()
	
	var tween = $transition_tween
	tween.interpolate_property($create_room, "offset", on_screen, above_screen, transition_duration, transition_method, easing)
	tween.start()
	
	emit_signal("begin_hosting", name_field.get_text())

func not_valid_name(input_name):
	
	var all_spaces = true
	for c in input_name:
		if c != " ":
			all_spaces = false
	return all_spaces

func connect_to_host(host_name, room_id):
	
	if not accept_input:
		return
	accept_input = false
	$audio/button_push.play()
	
	var tween = $transition_tween
	tween.interpolate_property($UI, "offset", on_screen, above_screen, transition_duration, transition_method, easing)
	tween.start()
	
	emit_signal("join_host", host_name, room_id)

