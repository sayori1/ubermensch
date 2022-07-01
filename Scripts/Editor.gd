extends Panel

var fileName = null:
	set(v):
		fileName = v
		Global.status.statusText = 'You are editing: ' + v;

func _init():
	Global.editor = self

func getContent():
	return $TextEdit.text;
	
func saveFile():
	if(fileName == null):
		fileName = await Global.commandPallete.prompt('Enter the file name')
	
	Global.fileService.saveFile(fileName, getContent())
	await Global.notification.showPopup('[rainbow]File saved![/rainbow]')

func openFile(fileName):
	if(Global.fileService.fileExists(fileName)):
		var content = Global.fileService.loadFile(fileName)
		print(content)
		self.fileName = fileName
		$TextEdit.text = content;
	else:
		Global.notification.showPopup("File doesn't exist")

func _input(event):
	if(event is InputEventKey):
		$TextEdit.editable = !(event as InputEventKey).ctrl_pressed
