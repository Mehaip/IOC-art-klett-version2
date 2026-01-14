extends Control

var current_planet = ""
var questions = []
var current_question_index = 0
var correct_answers = 0
var waiting_for_next = false
var is_initialized = false

func _ready():
	if is_initialized:
		load_question()

func set_planet(planet_name: String):
	current_planet = planet_name
	questions = QuizData.get_questions(planet_name)
	$VBoxContainer/PlanetNameLabel.text = planet_name
	is_initialized = true
	if is_inside_tree():
		load_question()

func load_question():
	if current_question_index >= questions.size():
		complete_quiz()
		return

	var question_data = questions[current_question_index]

	$VBoxContainer/ProgressLabel.text = "Întrebare %d/5" % (current_question_index + 1)
	$VBoxContainer/QuestionLabel.text = question_data["question"]

	var answer_buttons = [
		$VBoxContainer/Answer1,
		$VBoxContainer/Answer2,
		$VBoxContainer/Answer3,
		$VBoxContainer/Answer4
	]

	for i in range(4):
		if i < question_data["answers"].size():
			answer_buttons[i].text = question_data["answers"][i]
			answer_buttons[i].visible = true
			answer_buttons[i].disabled = false
		else:
			answer_buttons[i].visible = false

	$FeedbackLabel.text = ""
	waiting_for_next = false

func _on_answer_pressed(answer_index: int):
	if waiting_for_next:
		return

	var question_data = questions[current_question_index]
	var is_correct = answer_index == question_data["correct"]

	if is_correct:
		correct_answers += 1
		$FeedbackLabel.text = "Corect ✓"
		$FeedbackLabel.add_theme_color_override("font_color", Color.GREEN)
	else:
		$FeedbackLabel.text = "Greșit X"
		$FeedbackLabel.add_theme_color_override("font_color", Color.RED)

	waiting_for_next = true

	var answer_buttons = [
		$VBoxContainer/Answer1,
		$VBoxContainer/Answer2,
		$VBoxContainer/Answer3,
		$VBoxContainer/Answer4
	]

	for button in answer_buttons:
		button.disabled = true

	await get_tree().create_timer(1.5).timeout

	if is_correct:
		current_question_index += 1
		load_question()
	else:
		restart_quiz()

func restart_quiz():
	current_question_index = 0
	correct_answers = 0
	load_question()

func complete_quiz():
	if correct_answers == 5:
		var meteorite_scene = load("res://scenes/meteorite_dodge.tscn").instantiate()
		meteorite_scene.set_planet(current_planet)
		get_tree().root.add_child(meteorite_scene)
		get_tree().current_scene.queue_free()
		get_tree().current_scene = meteorite_scene
	else:
		get_tree().change_scene_to_file("res://scenes/game_world.tscn")
