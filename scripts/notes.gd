extends CanvasLayer

func _ready():
	var saved_notes = GameState.get_notes()
	$Container/VBoxContainer/TextEdit.text = saved_notes

func _on_save_button_pressed():
	var text = $Container/VBoxContainer/TextEdit.text
	GameState.save_notes(text)
	$Container/VBoxContainer/StatusLabel.text = "Notițele au fost salvate! ✓"
	$Container/VBoxContainer/StatusLabel.add_theme_color_override("font_color", Color.GREEN)

	await get_tree().create_timer(2.0).timeout
	$Container/VBoxContainer/StatusLabel.text = ""

func _on_exit_button_pressed():
	queue_free()
