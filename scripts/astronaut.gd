extends CharacterBody2D

const SPEED = 200.0

var nearby_planet = null
var can_move = true

func _ready():
	$InteractionArea.area_entered.connect(_on_area_entered)
	$InteractionArea.area_exited.connect(_on_area_exited)

func _physics_process(delta):
	if can_move == false:
		return
	var input_vector = Vector2.ZERO

	if Input.is_action_pressed("ui_right"):
		input_vector.x += 1
	if Input.is_action_pressed("ui_left"):
		input_vector.x -= 1
	if Input.is_action_pressed("ui_down"):
		input_vector.y += 1
	if Input.is_action_pressed("ui_up"):
		input_vector.y -= 1

	if input_vector != Vector2.ZERO:
		input_vector = input_vector.normalized()

	velocity = input_vector * SPEED
	move_and_slide()
	
	var screen_size = get_viewport_rect().size
	var padding = 32
	position.x = clamp(position.x, padding, screen_size.x - padding)
	position.y = clamp(position.y, padding, screen_size.y - padding)

func _input(event):
	if event.is_action_pressed("interact") and nearby_planet:
		nearby_planet.interact()

func _on_area_entered(area):
	if area.get_parent().has_method("interact"):
		nearby_planet = area.get_parent()

func _on_area_exited(area):
	if area.get_parent() == nearby_planet:
		nearby_planet = null
