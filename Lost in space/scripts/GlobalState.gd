extends Node

const INACTIVITY_TIMEOUT := 2.0

var last_mouse_pos := Vector2.ZERO
var mouse_visible := true
var inactivity_timer := 0.0

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _process(delta):
	var moved_with_keys := Input.is_action_pressed("ui_up") \
		|| Input.is_action_pressed("ui_down") \
		|| Input.is_action_pressed("ui_left") \
		|| Input.is_action_pressed("ui_right")
	
	if moved_with_keys and mouse_visible:
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
		mouse_visible = false
	
	var current_mouse_pos = get_viewport().get_mouse_position()
	if current_mouse_pos.distance_to(last_mouse_pos) > 1:
		if not mouse_visible:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			mouse_visible = true
		inactivity_timer = 0.0  # reset timer

	last_mouse_pos = current_mouse_pos

	if mouse_visible:
		inactivity_timer += delta
		if inactivity_timer > INACTIVITY_TIMEOUT:
			Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
			mouse_visible = false


var last_scene := ""
var save_path := "user://save_checkpoint.json"

func save_checkpoint(scene_path: String):
	last_scene = scene_path
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	var data = { "scene": scene_path }
	file.store_string(JSON.stringify(data))
	print("Checkpoint reached :", scene_path)

func load_checkpoint() -> String:
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		var json = file.get_as_text()
		var result = JSON.parse_string(json)
		if typeof(result) == TYPE_DICTIONARY and result.has("scene"):
			last_scene = result["scene"]
			print("Checkpoint loaded :", last_scene)
			return last_scene
	return ""
	
