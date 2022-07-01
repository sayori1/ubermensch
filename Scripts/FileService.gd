extends Node

var userPath = 'user://';

func _init():
	Global.fileService = self;

func saveFile(fileName, data):
	if(fileName == null):
		fileName = "unnamed";
	var file = File.new()
	file.open(userPath + fileName, File.WRITE)
	file.store_string(data)
	file.close()

func loadFile(fileName):
	print(fileName)
	var file = File.new()
	file.open(userPath + fileName, File.READ)
	var content = file.get_as_text()
	file.close()
	return content
	
func createFolder(folderName):
	var dir = Directory.new()
	dir.open(userPath)
	dir.make_dir(folderName)
	
func fileExists(fileName):
	return (Directory.new().file_exists(userPath + fileName));
