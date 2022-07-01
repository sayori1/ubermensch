extends Control

func _ready():
	addGroup('To do')
	addGroup('In progress')
	addGroup('Done')
	addTask('task1', 'To do', 10)
	while true:
		await get_tree().create_timer(0.1).timeout
		tick1Minute()

func addGroup(groupName:String):
	var panel = preload('res://Prefabs/Group.tscn');
	var duplicate = panel.instantiate()
	duplicate.name = groupName
	duplicate.get_node('Name').text = groupName
	$Panel/ScrollContainer/HBoxContainer.add_child(duplicate)
	duplicate.get_node('Name/Add').connect('button_down', addTaskFromGroup, [duplicate])

func addTaskFromGroup(group):
	var data = await $CreateNewTask.request();
	addTask(data.name, group.name, data.time.to_int())
	
func addTask(taskName:String, groupName:String, time:int):
	var prefab = preload("res://Prefabs/Task.tscn")
	var duplicate = prefab.instantiate()
	duplicate.name = taskName
	duplicate.init(taskName, time, groupName)
	$Panel/ScrollContainer/HBoxContainer.get_node(groupName + '/Content').add_child(duplicate)
	
	duplicate.groupName = groupName
	duplicate.connect('button_down', taskButtonDown, [duplicate])
	duplicate.connect('button_up', taskButtonUp, [duplicate.name, groupName])
	
func deleteTask(taskName:String, groupName: String):
	for realTask in $Panel/ScrollContainer/HBoxContainer.get_node(groupName+'/Content').get_children():
		if(realTask.name == taskName):
			realTask.queue_free()
	
func getGroups():
	return $Panel/ScrollContainer/HBoxContainer.get_children()

func getGroup(groupName):
	for group in getGroups():
		if(group.name == groupName):
			return group.get_node('Content');

func getTasks(groupName):
	return getGroup(groupName).get_children()

func getTask(taskName, groupName):
	for task in getTasks(groupName):
		if(task.name == taskName):
			return task

func moveTask(taskName, from, to):
	if(from == to):
		return;
	var task = getTask(taskName, from)
	if(task == null):
		return
	task = task.deepDuplicate();
	task.groupName = to;
	
	task.connect('button_down', taskButtonDown, [task])
	task.connect('button_up', taskButtonUp, [task.name, to])
	
	deleteTask(taskName, from);
	getGroup(to).add_child(task)
	return task;
	
#for moving tasks
var current = null
var selectedGroup = null 
var offset = null
func taskButtonDown(task):
	current = task
	
func taskButtonUp(taskName:String, groupName:String):
	moveTask(taskName, groupName, selectedGroup.name);
	
	selectedGroup.get_node('Active').visible = false
	selectedGroup = null
	current = null
	offset = null
	
func _process(delta):
	if(current!=null):
		if(offset == null):
			offset =  get_global_mouse_position() - current.global_position
		current.global_position = get_global_mouse_position() - offset;
		for group in $Panel/ScrollContainer/HBoxContainer.get_children():
			if((group.global_position as Vector2).distance_to(current.global_position) < 100):
				if(selectedGroup != null):
					selectedGroup.get_node('Active').visible = false
				selectedGroup = group
				selectedGroup.get_node('Active').visible = true
#tick
func tick1Minute():
	var tasks = getTasks("In progress")
	for task in tasks:
		task.progress += 1
		if(task.completed):
			moveTask(task.name, task.groupName, 'Done')
