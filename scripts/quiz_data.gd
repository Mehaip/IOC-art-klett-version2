extends Node

var quiz_questions = {
	"Mercury": [
		{
			"question": "Care este cea mai apropiată planetă de Soare?",
			"answers": ["Mercur", "Venus", "Pământ", "Marte"],
			"correct": 0
		},
		{
			"question": "Mercur este cea mai mică planetă din Sistemul Solar?",
			"answers": ["Da", "Nu, este Pluto", "Nu, este Marte", "Nu, este Venus"],
			"correct": 0
		},
		{
			"question": "Cât durează o zi pe Mercur?",
			"answers": ["58 de zile terestre", "24 de ore", "10 ore", "365 de zile"],
			"correct": 0
		},
		{
			"question": "Mercur are atmosferă densă?",
			"answers": ["Nu, are o atmosferă foarte subțire", "Da, foarte densă", "Nu are atmosferă deloc", "Are atmosferă de oxigen"],
			"correct": 0
		},
		{
			"question": "La ce temperatură poate ajunge Mercur ziua?",
			"answers": ["Peste 400°C", "100°C", "0°C", "-200°C"],
			"correct": 0
		}
	],
	"Venus": [
		{
			"question": "Care planetă este numită 'steaua dimineții' sau 'steaua serii'?",
			"answers": ["Venus", "Marte", "Jupiter", "Mercur"],
			"correct": 0
		},
		{
			"question": "Venus se rotește în aceeași direcție ca celelalte planete?",
			"answers": ["Nu, se rotește în sens invers", "Da", "Nu se rotește deloc", "Se rotește vertical"],
			"correct": 0
		},
		{
			"question": "Ce gaz formează majoritatea atmosferei lui Venus?",
			"answers": ["Dioxid de carbon", "Oxigen", "Azot", "Hidrogen"],
			"correct": 0
		},
		{
			"question": "Venus este cea mai fierbinte planetă din Sistemul Solar?",
			"answers": ["Da", "Nu, este Mercur", "Nu, este Soarele", "Nu, este Marte"],
			"correct": 0
		},
		{
			"question": "Venus este asemănătoare ca mărime cu ce planetă?",
			"answers": ["Pământul", "Marte", "Jupiter", "Mercur"],
			"correct": 0
		}
	],
	"Earth": [
		{
			"question": "Ce procent din suprafața Pământului este acoperit de apă?",
			"answers": ["Aproximativ 70%", "50%", "30%", "90%"],
			"correct": 0
		},
		{
			"question": "Câți sateliți naturali (luni) are Pământul?",
			"answers": ["Unul", "Doi", "Niciunul", "Trei"],
			"correct": 0
		},
		{
			"question": "Care este singurul corp ceresc pe care știm sigur că există viață?",
			"answers": ["Pământul", "Marte", "Europa (luna lui Jupiter)", "Venus"],
			"correct": 0
		},
		{
			"question": "Cât durează o rotație completă a Pământului în jurul axei sale?",
			"answers": ["Aproximativ 24 de ore", "12 ore", "365 de zile", "48 de ore"],
			"correct": 0
		},
		{
			"question": "Ce face atmosfera Pământului pentru viața de pe planetă?",
			"answers": ["Protejează de radiații și menține temperatura", "Doar dă culoare cerului", "Face ploaie", "Nimic special"],
			"correct": 0
		}
	],
	"Mars": [
		{
			"question": "De ce este Marte numit 'Planeta Roșie'?",
			"answers": ["Din cauza oxidului de fier (rugină) de pe suprafața sa", "Din cauza lavei", "Din cauza norilor roșii", "Din cauza apei roșii"],
			"correct": 0
		},
		{
			"question": "Câte luni are Marte?",
			"answers": ["Două (Phobos și Deimos)", "Una", "Trei", "Niciunul"],
			"correct": 0
		},
		{
			"question": "Ce formațiune geologică pe Marte este cel mai mare vulcan din Sistemul Solar?",
			"answers": ["Olympus Mons", "Valles Marineris", "Mount Everest", "Tharsis"],
			"correct": 0
		},
		{
			"question": "Au fost găsite urme de apă pe Marte?",
			"answers": ["Da, există dovezi de apă în trecut și gheață acum", "Nu, niciodată", "Doar în imaginație", "Marte este acoperit cu oceane"],
			"correct": 0
		},
		{
			"question": "O zi pe Marte durează aproximativ cât o zi pe Pământ?",
			"answers": ["Da, aproximativ 24 ore și 37 minute", "Nu, 12 ore", "Nu, 48 ore", "Nu, 10 ore"],
			"correct": 0
		}
	],
	"Jupiter": [
		{
			"question": "Jupiter este cea mai mare planetă din Sistemul Solar?",
			"answers": ["Da", "Nu, Saturn este mai mare", "Nu, Uranus este mai mare", "Nu, Neptun este mai mare"],
			"correct": 0
		},
		{
			"question": "Ce este 'Marea Pată Roșie' de pe Jupiter?",
			"answers": ["O furtună uriașă care durează de sute de ani", "Un vulcan activ", "Un ocean roșu", "Un crater mare"],
			"correct": 0
		},
		{
			"question": "Din ce este făcut în principal Jupiter?",
			"answers": ["Gaze (hidrogen și heliu)", "Piatră", "Metal", "Apă"],
			"correct": 0
		},
		{
			"question": "Aproximativ câte luni are Jupiter?",
			"answers": ["Peste 90", "4", "12", "1"],
			"correct": 0
		},
		{
			"question": "Care este cea mai mare lună a lui Jupiter și din Sistemul Solar?",
			"answers": ["Ganymede", "Europa", "Io", "Callisto"],
			"correct": 0
		}
	],
	"Saturn": [
		{
			"question": "Pentru ce este cunoscut în mod special Saturn?",
			"answers": ["Pentru inelele sale spectaculoase", "Pentru că este roșu", "Pentru că este cel mai mic", "Pentru că are oceane"],
			"correct": 0
		},
		{
			"question": "Din ce sunt făcute inelele lui Saturn?",
			"answers": ["Gheață și bucăți de rocă", "Gaze colorate", "Metal", "Praf și nisip"],
			"correct": 0
		},
		{
			"question": "Saturn este o planetă gazoasă?",
			"answers": ["Da", "Nu, este stâncoasă", "Nu, este lichidă", "Este făcut din metal"],
			"correct": 0
		},
		{
			"question": "Saturn este a doua cea mai mare planetă din Sistemul Solar?",
			"answers": ["Da", "Nu, este cea mai mare", "Nu, este a treia", "Nu, este a patra"],
			"correct": 0
		},
		{
			"question": "Ce planetă ar pluti pe apă dacă ar exista un ocean suficient de mare?",
			"answers": ["Saturn (este mai puțin dens decât apa)", "Jupiter", "Pământul", "Marte"],
			"correct": 0
		}
	],
	"Uranus": [
		{
			"question": "Ce culoare are Uranus?",
			"answers": ["Albastru-verde", "Roșu", "Galben", "Maro"],
			"correct": 0
		},
		{
			"question": "Ce este neobișnuit la rotația lui Uranus?",
			"answers": ["Se rotește aproape pe lateral (axa sa este înclinată)", "Nu se rotește deloc", "Se rotește foarte rapid", "Se rotește invers"],
			"correct": 0
		},
		{
			"question": "Ce gaz dă culoarea albastru-verde lui Uranus?",
			"answers": ["Metan", "Oxigen", "Azot", "Hidrogen"],
			"correct": 0
		},
		{
			"question": "Uranus are inele?",
			"answers": ["Da, dar sunt foarte slabe", "Nu", "Da, mai mari decât ale lui Saturn", "Are doar unul"],
			"correct": 0
		},
		{
			"question": "Uranus este o planetă gazoasă sau stâncoasă?",
			"answers": ["Gazoasă (gigant de gheață)", "Stâncoasă", "Metalică", "Lichidă"],
			"correct": 0
		}
	],
	"Neptune": [
		{
			"question": "Ce culoare are Neptun?",
			"answers": ["Albastru intens", "Verde", "Roșu", "Galben"],
			"correct": 0
		},
		{
			"question": "Neptun este cea mai îndepărtată planetă de Soare în Sistemul Solar?",
			"answers": ["Da", "Nu, Pluto este", "Nu, Uranus este", "Nu, Marte este"],
			"correct": 0
		},
		{
			"question": "Pe Neptun vânturile pot ajunge la viteze foarte mari. Aproximativ cât de rapide?",
			"answers": ["Peste 2000 km/h", "100 km/h", "500 km/h", "50 km/h"],
			"correct": 0
		},
		{
			"question": "Care este cea mai mare lună a lui Neptun?",
			"answers": ["Triton", "Europa", "Titan", "Luna"],
			"correct": 0
		},
		{
			"question": "Neptun a fost descoperit prin calcule matematice înainte de a fi văzut?",
			"answers": ["Da", "Nu, a fost descoperit întâmplător", "Nu, era cunoscut din antichitate", "Nu, nu a fost niciodată descoperit"],
			"correct": 0
		}
	]
}

func get_questions(planet_name: String) -> Array:
	if planet_name not in quiz_questions:
		return []

	# facem o copie ca sa nu modificam structura originala
	var result = []
	for q in quiz_questions[planet_name]:
		var question_copy = q.duplicate(true)

		var answers = question_copy["answers"]
		var correct_answer_text = answers[question_copy["correct"]]

		# amestecam raspunsurile
		answers.shuffle()

		# recalculam index-ul raspunsului corect dupa shuffle
		question_copy["correct"] = answers.find(correct_answer_text)

		result.append(question_copy)

	return result
