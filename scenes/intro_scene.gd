extends Control

@onready var text_box: Label = $IntroText
@onready var timer: Timer = $TextTimer

var lines: Array = [
	{ "text": "It wasn't a war against the system.", "pause": 2.5 },
	{ "text": "It was the numb slumber, after the fall.", "pause": 2.5 },
	{ "text": "It was silence.", "pause": 1 },
	{ "text": "Disbelief.", "pause": 1.3},
	{ "text": "What was left behind —", "pause": 1.8 },
	{ "text": "The scattered echoes of stories no one remembered.", "pause": 2.5 },
	{ "text": "It was those feint voices", "pause": 1.2 },
	{ "text": "whispering loud", "pause": 1.2 },
	{ "text": "not to be forgotten..", "pause": 3.4 }
]

var current_index: int = 0
var is_animating: bool = false

func _ready():
	text_box.text = ""
	text_box.modulate.a = 0.0
	timer.start()

func _on_text_timer_timeout():
	if is_animating:
		return

	if current_index < lines.size():
		await show_line(lines[current_index])
		current_index += 1
	else:
		timer.stop()
		await get_tree().create_timer(2.0).timeout
		get_tree().change_scene_to_file("res://scenes/title_screen.tscn")

func show_line(line_data: Dictionary):
	is_animating = true

	var new_text: String = line_data["text"]
	var pause_duration: float = line_data.get("pause", 2.0)
	var fade_in_time: float = line_data.get("fade_in", 0.5)
	var fade_out_time: float = line_data.get("fade_out", 0.5)
	var append: bool = line_data.get("append", false)

	if append:
		var preserved_text: String = text_box.text
		text_box.text = preserved_text + "\n" + new_text
	else:
		text_box.text = ""
		text_box.modulate.a = 0.0
		text_box.text = new_text

		var fade_in := create_tween()
		fade_in.tween_property(text_box, "modulate:a", 1.0, fade_in_time)
		await fade_in.finished

	await get_tree().create_timer(pause_duration).timeout

	if not append:
		var fade_out := create_tween()
		fade_out.tween_property(text_box, "modulate:a", 0.0, fade_out_time)
		await fade_out.finished

	is_animating = false
	
