extends Sprite

onready var tween = $swing_tween

var swing_start = 30
var swing_end = -30
var duration = 0.8

var spin_final = (360 * 3) + 30
var spin_duration = 1.4

var icon_spin_final = spin_final - 30

func _ready():
	
	_on_swing_tween_tween_all_completed()

func _on_swing_tween_tween_all_completed():
	
	var tween_method = Tween.TRANS_CUBIC
	
	if self.rotation_degrees == swing_end:
		tween.interpolate_property(self, "rotation_degrees", swing_end, swing_start, duration, tween_method, Tween.EASE_IN_OUT)
		tween.start()
	else:
		tween.interpolate_property(self, "rotation_degrees", swing_start, swing_end, duration, tween_method, Tween.EASE_IN_OUT)
		tween.start()

func do_refresh_spin(icon):
	
	tween.stop_all()
	
	var tween_method = Tween.TRANS_QUART
	
	tween.interpolate_property(icon, "rotation_degrees", 0, icon_spin_final, spin_duration, tween_method, Tween.EASE_OUT)
	tween.interpolate_property(self, "rotation_degrees", int(self.rotation_degrees) % 360, spin_final, spin_duration, tween_method, Tween.EASE_OUT)
	tween.start()
	
	
