extends Node2D

@export var planet_name: String = "Planet"
@export var planet_color: Color = Color.WHITE
@export var planet_scale: float = 1.0

var is_unlocked = false
var player_nearby = false

func _ready():
	$NameLabel.text = planet_name.replace("_", " ")

	# Load planet sprite texture
	var texture_path = "res://assets/" + planet_name.to_lower() + ".png"

	if FileAccess.file_exists(texture_path):
		var texture = load(texture_path)
		$PlanetSprite.texture = texture
		$PlanetSprite.scale = Vector2(planet_scale * 0.3, planet_scale * 0.3)
	else:
		# Fallback for planets without sprites - create a colored circle
		var circle = ColorRect.new()
		circle.custom_minimum_size = Vector2(80, 80) * planet_scale
		circle.size = Vector2(80, 80) * planet_scale
		circle.position = Vector2(-40, -40) * planet_scale
		circle.color = planet_color
		$PlanetSprite.add_child(circle)

	if planet_name == "HAI_SA_INVATAM":
		$NameLabel.text = "HAI SA INVATAM"
		var face = Label.new()
		face.text = "☺"
		face.add_theme_font_size_override("font_size", 40)
		face.position = Vector2(-20, -20)
		$PlanetSprite.add_child(face)

	if planet_name == "NOTITE":
		$NameLabel.text = "NOTITE"
		var icon = Label.new()
		icon.text = "📝"
		icon.add_theme_font_size_override("font_size", 40)
		icon.position = Vector2(-20, -20)
		$PlanetSprite.add_child(icon)

	update_status()

	$InteractionArea.body_entered.connect(_on_body_entered)
	$InteractionArea.body_exited.connect(_on_body_exited)

func _process(delta):
	update_status()
	$PromptLabel.visible = player_nearby

func update_status():
	is_unlocked = GameState.is_planet_unlocked(planet_name)

	if is_unlocked:
		$StatusIndicator/StatusLabel.text = "✓"
		$StatusIndicator/StatusLabel.add_theme_color_override("font_color", Color.GREEN)
	else:
		$StatusIndicator/StatusLabel.text = "X"
		$StatusIndicator/StatusLabel.add_theme_color_override("font_color", Color.RED)

func interact():
	if planet_name == "HAI_SA_INVATAM":
		open_image_gallery()
	elif planet_name == "NOTITE":
		open_notes()
	elif is_unlocked:
		pass
	else:
		start_quiz()

func start_quiz():
	var quiz_scene = load("res://scenes/quiz.tscn").instantiate()
	quiz_scene.set_planet(planet_name)
	get_tree().root.add_child(quiz_scene)
	get_tree().current_scene.queue_free()
	get_tree().current_scene = quiz_scene

func open_image_gallery():
	var gallery_scene = load("res://scenes/image_gallery.tscn").instantiate()
	get_tree().root.add_child(gallery_scene)

func open_notes():
	var notes_scene = load("res://scenes/notes.tscn").instantiate()
	get_tree().root.add_child(notes_scene)

func _on_body_entered(body):
	if body.name == "Astronaut":
		player_nearby = true

func _on_body_exited(body):
	if body.name == "Astronaut":
		player_nearby = false
