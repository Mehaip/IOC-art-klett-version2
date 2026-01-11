extends Node2D

var planet_to_unlock = ""
var elapsed_time = 0.0
var game_over = false
var meteorites = []
var stars = []
var astronaut
var meteorites_can_move = true

func set_planet(planet_name: String):
	planet_to_unlock = planet_name

func _ready():
	generate_stars()
	
	astronaut = $Player
	if astronaut:
		astronaut.can_move = true
	
	meteorites_can_move = true
	
	$UI/HighscoreLabel.text = "Best: %.1fs" % GameState.meteorite_highscore
	$Player/InteractionArea.area_entered.connect(_on_player_hit)
	$SpawnTimer.timeout.connect(_on_spawn_timer_timeout)

func generate_stars():
	var star_container = $Background/Stars
	for i in range(200):
		var star = ColorRect.new()
		var size = randf_range(1, 3)
		star.custom_minimum_size = Vector2(size, size)
		star.size = Vector2(size, size)
		star.position = Vector2(randf_range(0, 1280), randf_range(0, 720))
		star.color = Color(1, 1, 1, randf_range(0.3, 1.0))
		star_container.add_child(star)
		stars.append(star)

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
	if meteorites_can_move == false:
		return
		
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
	astronaut.can_move = false
	meteorites_can_move = false
	GameState.update_highscore(elapsed_time)
	GameState.unlock_planet(planet_to_unlock)

	$UI/TimerLabel.text = "Hit! Time: %.1fs" % elapsed_time
	
	await get_tree().create_timer(2.0).timeout
	astronaut.can_move = true
	meteorites_can_move = true
	get_tree().change_scene_to_file("res://scenes/game_world.tscn")
