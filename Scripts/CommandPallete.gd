extends TextEdit

signal accept

var isPrompting = false
var commands: Dictionary = {
	'open': func(args):Global.editor.openFile(args[-1]),
	'create': func(args):Global.editor.fileName = args[-1],
	'push': func(args): Global.saveWorkspace(),
	'git init': func(args): Global.git.setUp()
}

func _init():
	Global.commandPallete = self

func prompt(hint):
	grab_focus()
		
	isPrompting = true
	text = ""
	placeholder_text = hint
	
	await accept
	
	isPrompting = false
	placeholder_text = ""
	return text.replace('\n', '')
	
func _process(delta):
	if(Input.is_action_just_pressed('ui_enter')):
		emit_signal('accept')
		commandHandler()
		text = ""

func onTextChanded():
	var target = ""
	for command in commands:
		if((command as String).begins_with(text)):
			target = command;
	$Placeholder.text = target

func commandHandler():
	for command in commands:
		if((text as String).begins_with(command) and text.contains(command)):
			print(command)
			commands[command].call(text.substr(command.length()).split(' '))
