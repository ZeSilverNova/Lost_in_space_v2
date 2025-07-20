extends Control

var options = [
	{ "label": "Load Game", "action": "continue_game" },
	{ "label": "New Game", "action": "new_game" },
]

var current_index = 0

func _ready():
	update_display()

func update_display():
	$Options.text = options[current_index]["label"]

func _on_back_to_main_pressed():
	get_tree().change_scene_to_file("res://scenes/title_screen.tscn")

func _on_confirmation_button_pressed():
	match options[current_index]["action"]:
		"new_game":
			GlobalState.save_checkpoint("user://save_checkpoint.json")
			get_tree().change_scene_to_file("res://scenes/intro_scene.tscn")

		"continue_game":
			var checkpoint = GlobalState.load_checkpoint()
			if checkpoint != "user://save_checkpoint.json":
				get_tree().change_scene_to_file(checkpoint)
			else:
				print("No previous save detected.")

func _on_left_button_pressed():
	current_index = (current_index - 1 + options.size()) % options.size()
	update_display()

func _on_right_button_pressed():
	current_index = (current_index + 1) % options.size()
	update_display()
