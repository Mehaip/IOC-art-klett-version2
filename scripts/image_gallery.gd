extends CanvasLayer

var images = []
var current_image_index = 0
var zoom_level = 1.0
var base_size = Vector2(800, 450)

func _ready():
	load_images()
	display_current_image()

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
					print("Found image: ", full_path)
			file_name = dir.get_next()
		dir.list_dir_end()
	else:
		print("Failed to open pics directory")

	images.sort()
	print("Total images loaded: ", images.size())

func display_current_image():
	if images.size() == 0:
		$Container/ScrollContainer/CenterContainer/ImageDisplay.texture = null
		$Container/ButtonPanel/HBoxContainer/PageLabel.text = "Nicio imagine"
		return

	var image_path = images[current_image_index]
	print("Loading image: ", image_path)

	var texture = ResourceLoader.load(image_path)
	if texture:
		$Container/ScrollContainer/CenterContainer/ImageDisplay.texture = texture
		update_image_size()
		print("Image loaded successfully")
	else:
		print("Failed to load image: ", image_path)
		$Container/ScrollContainer/CenterContainer/ImageDisplay.texture = null

	var current_page = current_image_index + 1
	var total_pages = images.size()
	$Container/ButtonPanel/HBoxContainer/PageLabel.text = str(current_page) + " / " + str(total_pages)

	$Container/ButtonPanel/HBoxContainer/PrevButton.disabled = (current_image_index == 0)
	$Container/ButtonPanel/HBoxContainer/NextButton.disabled = (current_image_index >= images.size() - 1)

	# Update zoom button states
	$Container/ButtonPanel/HBoxContainer/ZoomOutButton.disabled = (zoom_level <= 0.5)
	$Container/ButtonPanel/HBoxContainer/ZoomInButton.disabled = (zoom_level >= 3.0)

func update_image_size():
	var new_size = base_size * zoom_level
	$Container/ScrollContainer/CenterContainer/ImageDisplay.custom_minimum_size = new_size

	# Update the CenterContainer size to ensure proper centering
	var center_container = $Container/ScrollContainer/CenterContainer
	center_container.custom_minimum_size = new_size

func _on_prev_button_pressed():
	if current_image_index > 0:
		current_image_index -= 1
		zoom_level = 1.0  # Reset zoom when changing images
		display_current_image()

func _on_next_button_pressed():
	if current_image_index < images.size() - 1:
		current_image_index += 1
		zoom_level = 1.0  # Reset zoom when changing images
		display_current_image()

func _on_zoom_in_button_pressed():
	if zoom_level < 3.0:
		zoom_level += 0.25
		update_image_size()
		$Container/ButtonPanel/HBoxContainer/ZoomOutButton.disabled = false
		$Container/ButtonPanel/HBoxContainer/ZoomInButton.disabled = (zoom_level >= 3.0)

func _on_zoom_out_button_pressed():
	if zoom_level > 0.5:
		zoom_level -= 0.25
		update_image_size()
		$Container/ButtonPanel/HBoxContainer/ZoomInButton.disabled = false
		$Container/ButtonPanel/HBoxContainer/ZoomOutButton.disabled = (zoom_level <= 0.5)

func _on_exit_button_pressed():
	queue_free()
