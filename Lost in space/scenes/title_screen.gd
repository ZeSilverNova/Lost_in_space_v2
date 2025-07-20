extends Control

func _on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/play_menu.tscn")

func _on_jukebox_pressed():
	get_tree().change_scene_to_file("res://scenes/jukebox_menu.tscn")

func _on_Exit_pressed():
	$MainMenu/ExitConfirmation.popup_centered()

func _on_exit_confirmation_confirmed():
	get_tree().quit()
