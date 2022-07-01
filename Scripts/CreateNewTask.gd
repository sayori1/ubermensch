extends Panel

func request():
	visible = true
	await $Content/Button.button_up
	visible = false
	return {'name': $Content/Name.text, 'time': ($Content/Time.text), 'auto_restore': $Content/AutoRestore.toggle_mode}
