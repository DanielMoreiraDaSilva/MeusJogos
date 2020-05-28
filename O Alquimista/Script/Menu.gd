extends Control

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		_on_Start_pressed()
		
	if Input.is_action_just_pressed("ui_cancel"):
		_on_Exit_pressed()

func _on_Start_pressed():
	get_tree().change_scene("res://Cenario/Word.tscn")


func _on_Exit_pressed():
	get_tree().quit()

func _on_FullScreen_pressed():
	OS.window_fullscreen = true
