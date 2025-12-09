extends Node

const SAVE_PATH = "user://game_save.json"

var unlocked_planets = {
	"Mercury": false,
	"Venus": false,
	"Earth": false,
	"Mars": false,
	"Jupiter": false,
	"Saturn": false,
	"Uranus": false,
	"Neptune": false,
	"HAI_SA_INVATAM": true,  # Always unlocked
	"NOTITE": true  # Always unlocked
}

var meteorite_highscore = 0
var notes_text = ""

func _ready():
	load_game()

func unlock_planet(planet_name: String):
	if planet_name in unlocked_planets:
		unlocked_planets[planet_name] = true
		save_game()

func is_planet_unlocked(planet_name: String) -> bool:
	if planet_name in unlocked_planets:
		return unlocked_planets[planet_name]
	return false

func update_highscore(score: float):
	if score > meteorite_highscore:
		meteorite_highscore = score
		save_game()

func save_notes(text: String):
	notes_text = text
	save_game()

func get_notes() -> String:
	return notes_text

func save_game():
	var save_data = {
		"unlocked_planets": unlocked_planets,
		"meteorite_highscore": meteorite_highscore,
		"notes_text": notes_text
	}

	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(save_data))
		file.close()

func load_game():
	if not FileAccess.file_exists(SAVE_PATH):
		return

	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if file:
		var json_string = file.get_as_text()
		file.close()

		var json = JSON.new()
		var parse_result = json.parse(json_string)
		if parse_result == OK:
			var save_data = json.data
			if "unlocked_planets" in save_data:
				unlocked_planets = save_data["unlocked_planets"]
			if "meteorite_highscore" in save_data:
				meteorite_highscore = save_data["meteorite_highscore"]
			if "notes_text" in save_data:
				notes_text = save_data["notes_text"]
