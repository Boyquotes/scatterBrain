extends Node


onready var lobby = preload("res://lobby.tscn")
onready var host_room = preload("res://room.tscn")
onready var guest_room = preload("res://guest_room.tscn")

var transparent = Color(1, 1, 1, 0)
var visible = Color(1, 1, 1, 1)

# how much time the UI gives firestore to load before displaying
var firestore_wait_time = 0.8

onready var top_bg = $top_bg/background


func _ready():
	
	Firebase.Auth.login_anonymous()
	
	$active_scene/lobby.connect("begin_hosting", self, "create_host_room")
	$active_scene/lobby.connect("join_host", self, "create_guest_room")

func create_host_room(host_name):
	
	var new_host_room = host_room.instance()
	new_host_room.host_name = host_name
	new_host_room.connect("return_to_lobby", self, "back_to_lobby")
	
	# wait 0.5 seconds (for lobby transition) and delete active scene
	yield(get_tree().create_timer(0.5), "timeout")
	top_bg.modulate = visible
	for active_scene in $active_scene.get_children():
		active_scene.queue_free()
	
	$active_scene.add_child(new_host_room)
	# wait for firestore to load the room
	yield(get_tree().create_timer(firestore_wait_time), "timeout")
	
	var tween = $transition
	tween.interpolate_property(top_bg, "modulate", visible, transparent, 1, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	tween.start()
	
func create_guest_room(host_name, room_id):
	
	var new_guest_room = guest_room.instance()
	new_guest_room.host_name = host_name
	new_guest_room.room_document_id = room_id
	new_guest_room.connect("return_to_lobby", self, "back_to_lobby")
	
	# wait 0.5 seconds (for lobby transition) and delete active scene
	yield(get_tree().create_timer(0.5), "timeout")
	top_bg.modulate = visible
	for active_scene in $active_scene.get_children():
		active_scene.queue_free()
	
	$active_scene.add_child(new_guest_room)
	# wait for firestore to load the room
	yield(get_tree().create_timer(firestore_wait_time), "timeout")
	
	var tween = $transition
	tween.interpolate_property(top_bg, "modulate", visible, transparent, 1, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	tween.start()
	
func back_to_lobby():
	
	var new_lobby = lobby.instance()
	new_lobby.connect("begin_hosting", self, "create_host_room")
	new_lobby.connect("join_host", self, "create_guest_room")
	
	var tween = $transition
	var duration = 1
	tween.interpolate_property(top_bg, "modulate", transparent, visible, duration, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	tween.start()
	yield(get_tree().create_timer(duration), "timeout")
	
	# clear active scene
	for active_scene in $active_scene.get_children():
		active_scene.queue_free()
	yield(get_tree().create_timer(0.2), "timeout")
	
	top_bg.modulate = transparent
	$active_scene.add_child(new_lobby)
	
	









