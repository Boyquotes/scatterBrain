extends Panel

signal join_host

export var host_name = "DQ"
export var room_id = "ABC"

var orig_style


func _ready():
	
	$text.set_text(host_name + "'S ROOM")

func _on_join_room_button_down():
	
	orig_style = self.get("custom_styles/panel")
	var temp_style = orig_style.duplicate()
	temp_style.bg_color = Color.white
	self.set("custom_styles/panel", temp_style)
	$text.modulate = orig_style.bg_color

func _on_join_room_button_up():
	
	self.set("custom_styles/panel", orig_style)
	$text.modulate = Color.white

func _on_join_room_pressed():
	
	emit_signal("join_host", host_name, room_id)
