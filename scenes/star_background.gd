extends Node2D

var stars = []

func _ready():
	generate_stars()

func generate_stars():
	var star_container = $Background/Stars
	for i in range(200):
		var star = ColorRect.new()
		var size = randf_range(1, 3)
		star.custom_minimum_size = Vector2(size, size)
		star.size = Vector2(size, size)
		star.position = Vector2(
			randf_range(0, get_viewport_rect().size.x),
			randf_range(0, get_viewport_rect().size.y)
		)
		star.color = Color(1, 1, 1, randf_range(0.3, 1.0))
		star_container.add_child(star)
		stars.append(star)

func _process(delta):
	for star in stars:
		star.modulate.a = 0.5 + 0.5 * sin(Time.get_ticks_msec() / 1000.0 + star.position.x)
