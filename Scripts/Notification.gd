extends Panel

func _ready():
	Global.notification = self

func showPopup(text):
	$Label.text = text
	modulate.a = 0.0
	var tween = get_tree().create_tween()
	tween.tween_property(self, 'modulate:a', 1.0, 1.0)
	await tween.finished
	await closePopup()
	
func closePopup():
	modulate.a = 1.0
	var tween = get_tree().create_tween()
	tween.tween_property(self, 'modulate:a', 0.0, 1.0)
	await tween.finished
	$Label.text = ""
