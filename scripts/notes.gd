extends CanvasLayer

func _ready():
	var saved_notes = GameState.get_notes()
	$Container/VBoxContainer/TextEdit.text = saved_notes
	_hide_mobile_controls()

func _on_save_button_pressed():
	var text = $Container/VBoxContainer/TextEdit.text
	GameState.save_notes(text)
	$Container/VBoxContainer/StatusLabel.text = "Notitele au fost salvate ✓"
	$Container/VBoxContainer/StatusLabel.add_theme_color_override("font_color", Color.GREEN)

	await get_tree().create_timer(2.0).timeout
	$Container/VBoxContainer/StatusLabel.text = ""

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
