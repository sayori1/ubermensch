extends Node

var configs = {}

func _init():
	Global.configService = self;

func _ready():
	if(not Global.fileService.fileExists('.configs')):
		Global.fileService.saveFile('.configs', '{}')
	loadConfigs()

func loadConfigs():
	var json = JSON.new();
	
	var content = Global.fileService.loadFile('.configs')
	if(content == ''): content = '{}'
	var result = json.parse(content);
	
	if(result == OK):
		configs = json.get_data()
	else:
		Global.notification.showPopup('Error while retrieving configs file')
		
func saveConfigs():
	var json = JSON.new();
	var content = json.stringify(configs);
	Global.fileService.saveFile('.configs', content);
	Global.notification.showPopup('Configs saved!')
