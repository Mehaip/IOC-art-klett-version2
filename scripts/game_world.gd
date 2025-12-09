extends Node2D

var stars = []

func _ready():
	generate_stars()
	var camera = $Camera2D
	var astronaut = $Astronaut
	if astronaut:
		camera.reparent(astronaut)
		camera.position = Vector2.ZERO

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
	for star in stars:
		star.modulate.a = 0.5 + 0.5 * sin(Time.get_ticks_msec() / 1000.0 + star.position.x)
