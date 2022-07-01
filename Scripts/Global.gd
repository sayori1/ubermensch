extends Node2D

var git = null
var notification = null
var editor = null
var commandPallete = null
var fileService = null
var status = null
var configService = null

func saveWorkspace():
	var status = await Global.git.save()
	if status:
		await Global.notification.showPopup('Succesfully saved!')
	else:
		await Global.notification.showPopup('Error while saving')

func log(logData):
	print(logData)
