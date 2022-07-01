extends Control

class Task:
	var progress = 0
	var text = ""
	var time = 30
	func _init(text):
		self.text = text
		self.progress = 0

var groups = {}

func _ready():
	addGroup('Trash')
	addGroup('In progress')
	addTask('task1', 'Trash', '30m')

func addGroup(name):
	var panel = preload('res://Prefabs/Group.tscn');
	var duplicate = panel.instantiate()
	duplicate.name = name
	duplicate.get_node('Name').text = name
	$Panel/ScrollContainer/HBoxContainer.add_child(duplicate)
	
	groups[name] = []

func addTask(name, group, time):
	var task = preload("res://Prefabs/Task.tscn")
	var duplicate = task.instantiate()
	duplicate.name = name
	duplicate.text = name + " " + time
	$Panel/ScrollContainer/HBoxContainer.get_node(group + '/Content').add_child(duplicate)
	
	duplicate.connect('button_down', taskButtonDown, [duplicate])
	duplicate.connect('button_up', taskButtonUp, [duplicate])
	
#for moving tasks
func taskButtonDown():
	pass
	
func taskButtonUp():
	pass
