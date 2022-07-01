extends Panel

var statusText:
	get: return $StatusText.text;
	set(v):
		$StatusText.text = v

func _init():
	Global.status = self

func showForTime(message, delay):
	var buffer = self.statusText
	self.statusText = message
	await get_tree().create_timer(delay).timeout
	self.statusText = buffer
