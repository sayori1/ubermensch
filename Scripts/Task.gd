extends Button

var progress = 0:
	set(v):
		progress = v
		$ProgressBar.value = v
		$ProgressBar.visible = (v != 0)
		if(progress >= time && !completed):
			completed = true;
			onTaskCompleted()
			
var time = 30:
	set(v):
		time = v
		$ProgressBar.max_value = v

var groupName:
	set(v):
		groupName = v
		if(groupName == "In progress"):
			$ProgressBar.visible = true
var completed = false

func init(text = "simple task", time = 30, groupName = ""):
	self.text = text;
	self.time = time
	self.groupName = groupName
	$Time.text = str(time) + 'm';
	name = text
	
func onTaskCompleted():
	$ProgressBar.modulate = Color.GREEN_YELLOW

func deepDuplicate():
	var duplicate = duplicate();
	duplicate.init(text, time, groupName);
	duplicate.progress = progress;
	return duplicate;
