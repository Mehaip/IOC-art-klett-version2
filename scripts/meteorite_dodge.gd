extends Node2D

var planet_to_unlock = ""
var elapsed_time = 0.0
var game_over = false
var meteorites = []

func set_planet(planet_name: String):
	planet_to_unlock = planet_name

func _ready():
	$UI/HighscoreLabel.text = "Best: %.1fs" % GameState.meteorite_highscore
	$Player/InteractionArea.area_entered.connect(_on_player_hit)
	$SpawnTimer.timeout.connect(_on_spawn_timer_timeout)

func _process(delta):
	if not game_over:
		elapsed_time += delta
		$UI/TimerLabel.text = "%.1fs" % elapsed_time

		var spawn_rate = max(0.2, 1.0 - (elapsed_time / 30.0))
		$SpawnTimer.wait_time = spawn_rate

func _on_spawn_timer_timeout():
	if game_over:
		return

	spawn_meteorite()

func spawn_meteorite():
	var meteorite = $MeteoriteTemplate.duplicate()
	meteorite.visible = true

	var spawn_edge = randi() % 4
	var position_on_edge = randf()

	match spawn_edge:
		0:
			meteorite.position = Vector2(position_on_edge * 1280, 0)
		1:
			meteorite.position = Vector2(1280, position_on_edge * 720)
		2:
			meteorite.position = Vector2(position_on_edge * 1280, 720)
		3:
			meteorite.position = Vector2(0, position_on_edge * 720)

	var target = $Player.position
	var direction = (target - meteorite.position).normalized()
	var speed = randf_range(100, 300)

	meteorite.set_meta("velocity", direction * speed)
	$MeteoriteContainer.add_child(meteorite)
	meteorites.append(meteorite)

func _physics_process(delta):
	for meteorite in meteorites:
		if is_instance_valid(meteorite):
			var velocity = meteorite.get_meta("velocity")
			meteorite.position += velocity * delta

			if meteorite.position.x < -50 or meteorite.position.x > 1330 or \
			   meteorite.position.y < -50 or meteorite.position.y > 770:
				meteorite.queue_free()
				meteorites.erase(meteorite)

func _on_player_hit(area):
	if game_over:
		return

	if area.get_parent() == $MeteoriteContainer or area in meteorites:
		game_over = true
		end_game()

func end_game():
	GameState.update_highscore(elapsed_time)
	GameState.unlock_planet(planet_to_unlock)

	$UI/TimerLabel.text = "Hit! Time: %.1fs" % elapsed_time

	await get_tree().create_timer(2.0).timeout
	get_tree().change_scene_to_file("res://scenes/game_world.tscn")
