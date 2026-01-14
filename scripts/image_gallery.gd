extends CanvasLayer

var images = []
var current_image_index = 0
var zoom_level = 1.0
var base_size = Vector2(800, 450)

func _ready():
	load_images()
	display_current_image()
	_hide_mobile_controls()

func load_images():
	var dir = DirAccess.open("res://pics/")
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if not dir.current_is_dir() and not file_name.ends_with(".import"):
				if file_name.ends_with(".png") or file_name.ends_with(".jpg") or file_name.ends_with(".jpeg"):
					var full_path = "res://pics/" + file_name
					images.append(full_path)
			file_name = dir.get_next()
		dir.list_dir_end()

	images.sort()

func display_current_image():
	if images.size() == 0:
		$Container/ScrollContainer/CenterContainer/ImageDisplay.texture = null
		$Container/ButtonPanel/HBoxContainer/PageLabel.text = "Nicio imagine"
		return

	var image_path = images[current_image_index]
	var texture = ResourceLoader.load(image_path)
	$Container/ScrollContainer/CenterContainer/ImageDisplay.texture = texture

	update_image_size()

	var current_page = current_image_index + 1
	var total_pages = images.size()
	$Container/ButtonPanel/HBoxContainer/PageLabel.text = str(current_page) + " / " + str(total_pages)

	$Container/ButtonPanel/HBoxContainer/PrevButton.disabled = (current_image_index == 0)
	$Container/ButtonPanel/HBoxContainer/NextButton.disabled = (current_image_index >= images.size() - 1)

	$Container/ButtonPanel/HBoxContainer/ZoomOutButton.disabled = (zoom_level <= 0.5)
	$Container/ButtonPanel/HBoxContainer/ZoomInButton.disabled = (zoom_level >= 3.0)

func update_image_size():
	var new_size = base_size * zoom_level
	$Container/ScrollContainer/CenterContainer/ImageDisplay.custom_minimum_size = new_size
	$Container/ScrollContainer/CenterContainer.custom_minimum_size = new_size

func _on_prev_button_pressed():
	if current_image_index > 0:
		current_image_index -= 1
		zoom_level = 1.0
		display_current_image()

func _on_next_button_pressed():
	if current_image_index < images.size() - 1:
		current_image_index += 1
		zoom_level = 1.0
		display_current_image()

func _on_zoom_in_button_pressed():
	if zoom_level < 3.0:
		zoom_level += 0.25
		update_image_size()

func _on_zoom_out_button_pressed():
	if zoom_level > 0.5:
		zoom_level -= 0.25
		update_image_size()

func _on_exit_button_pressed():
	_show_mobile_controls()
	queue_free()

func _hide_mobile_controls():
	var controls = get_tree().root.get_node("GameWorld/MobileControls")
	if controls:
		controls.visible = false

func _show_mobile_controls():
	var controls = get_tree().root.get_node("GameWorld/MobileControls")
	if controls:
		controls.visible = true

func _unhandled_input(event):
	get_viewport().set_input_as_handled()
