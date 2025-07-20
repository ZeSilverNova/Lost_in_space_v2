extends Control

var tracks = [
	{ "name": "From a broken heart", "file": preload("res://songs/From_a_broken_heart.wav") },
	{ "name": "Millenial spleen", "file": preload("res://songs/Millenial_spleen.wav") },
	{ "name": "Summer nights", "file": preload("res://songs/Summer_nights.wav") }
]

var current_index = 0

func _ready():
	update_display()

func update_display():
	$TrackTitle.text = tracks[current_index]["name"]
	$AudioPlayed.stream = tracks[current_index]["file"]
	$AudioPlayed.play()

func _on_back_to_main_pressed():
	get_tree().change_scene_to_file("res://scenes/title_screen.tscn")

func _on_left_button_pressed():
	current_index = (current_index - 1 + tracks.size()) % tracks.size()
	update_display()

func _on_right_button_pressed():
	current_index = (current_index + 1) % tracks.size()
	update_display()

func _on_repeat_timer_timeout():
	$AudioPlayed.play()

func _on_audio_played_finished() -> void:
	$RepeatTimer.start()
