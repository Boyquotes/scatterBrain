extends Panel

signal key_typed
signal delete_key

export var letter = "Q"
export var is_delete_key = false

onready var normal_style = preload("res://resources/key.tres")
onready var pressed_style = preload("res://resources/key_panel_pressed.tres")

func _ready():
	$letter.set_text(letter) 
	
	if is_delete_key:
		$delete_icon/icon.visible = true
		set_letter("")
	
func set_letter(new_letter):
	letter = new_letter
	$letter.set_text(letter)

func _on_button_button_down():
	self.set("custom_styles/panel", pressed_style)
	$letter.modulate = Color("292929")
	$delete_icon.modulate = Color("292929")

func _on_button_button_up():
	self.set("custom_styles/panel", normal_style)
	$letter.modulate = Color.white
	$delete_icon.modulate = Color.white

func _on_button_pressed():
	if is_delete_key:
		emit_signal("delete_key")
	else:
		emit_signal("key_typed", letter)
