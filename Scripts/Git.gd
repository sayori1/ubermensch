extends Node

var username = null
var password = null
var url = null

func _ready():
	if(Global.configService.configs.has('username')):
		username = Global.configService.configs['username']
		password = Global.configService.configs['password']
		url = Global.configService.configs['url']
		print('loaded from configs file')

func _init():
	Global.git = self

func setUp():
	var _username = await Global.commandPallete.prompt('Enter the username');
	var _password = await Global.commandPallete.prompt('Enter the password(token)')
	var _url = await Global.commandPallete.prompt('Enter name of repository')
	
	if(_username != ""):
		username = _username
		
	if(_password != ""):
		password = _password
		
	if(_url != ""):
		url = _url
	
	Global.fileService.saveFile('.gitignore', 'logs/\nshader_cache/')
	setConfigs(username, password, url)
	
func setConfigs(username, password, url):
	Global.configService.configs['username'] = username
	Global.configService.configs['password'] = password
	Global.configService.configs['url'] = url
	Global.configService.saveConfigs()
	
func save():
	if(username == null):
		await setUp();
	
	var output = []
	await OS.execute('python', ['PythonScripts/Git.py', OS.get_user_data_dir(), username, password, url], output, true, true)
	print(output)
