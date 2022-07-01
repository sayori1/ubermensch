extends Node2D


func _input(ev):
	if(ev is InputEventKey):
		var keyEvent = ev as InputEventKey;
		if keyEvent.ctrl_pressed and keyEvent.keycode == KEY_S:
			await Global.editor.saveFile()
		if keyEvent.ctrl_pressed and keyEvent.keycode == KEY_G:
			await Global.saveWorkspace()
		#there you can add new keyboard events
