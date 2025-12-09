# Art Klett - Planete

An educational game about planets for 4th grade students, built with Godot 4.3.

## Features

### Main Game
- **Main Menu**: Space-themed menu with animated stars
- **Top-Down Exploration**: Control an astronaut in space, moving between planets
- **8 Planets**: Mercury, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune
- **Lock/Unlock System**: Complete quizzes to unlock planets (indicated by X/✓ symbols)

### Quiz System
- 5 questions per planet in Romanian
- 4 multiple-choice answers for each question
- Must get all 5 questions correct to proceed
- Questions restart if you get one wrong

### Meteorite Dodge Mini-Game
- Reward game after completing each planet's quiz
- Timer counts up to track survival time
- Increasing difficulty as time progresses
- High score tracking
- Unlocks the planet when completed (even if hit by meteorite)

### Special Planets

#### HAI SA INVATAM (Let's Learn)
- Image gallery displaying educational pictures
- Navigate between images with Previous/Next buttons
- Displays images from the `pics/` directory
- Always unlocked

#### NOTITE (Notes)
- Built-in notepad for taking notes
- Notes are saved automatically
- Persistent between game sessions
- Always unlocked

## Controls

### Keyboard (Laptop)
- **Arrow Keys**: Move astronaut up/down/left/right
- **E** or **Space**: Interact with planets

### Touch (Tablet)
- **On-screen buttons**: Directional arrows for movement
- **E button**: Interact with planets
- All controls are touch-friendly

## How to Run

1. Install [Godot 4.3](https://godotengine.org/download) or later
2. Open Godot Engine
3. Click "Import"
4. Navigate to this project folder and select `project.godot`
5. Click "Import & Edit"
6. Press F5 or click the Play button to run the game

## Exporting for Tablets

To export the game for Android tablets:

1. In Godot, go to **Project > Export**
2. Add an Android export template
3. Configure the Android SDK and build tools
4. Export the APK
5. Install on your tablet

## Game Structure

```
IOC_game_godot/
├── project.godot          # Project configuration
├── scenes/                # All game scenes
│   ├── main_menu.tscn    # Main menu
│   ├── game_world.tscn   # Main game world
│   ├── astronaut.tscn    # Player character
│   ├── planet.tscn       # Planet template
│   ├── quiz.tscn         # Quiz interface
│   ├── meteorite_dodge.tscn  # Dodge mini-game
│   ├── image_gallery.tscn    # Image viewer
│   └── notes.tscn        # Notes editor
├── scripts/               # All GDScript files
│   ├── game_state.gd     # Save/load system
│   ├── quiz_data.gd      # Quiz questions database
│   └── [other scripts]
├── pics/                  # Educational images
│   ├── 1.png
│   ├── 2.png
│   ├── 3.png
│   └── 4.png
└── data/                  # Save files (created at runtime)
```

## Save System

The game automatically saves:
- Unlocked planets
- High score for meteorite dodge game
- Notes text

Save file location: `user://game_save.json` (in Godot's user data directory)

## Educational Content

The game includes comprehensive Romanian-language quiz questions about:
- Physical characteristics of each planet
- Orbital and rotational properties
- Atmospheric composition
- Unique features and phenomena
- Comparative facts between planets

## Customization

### Adding More Quiz Questions
Edit `scripts/quiz_data.gd` to add more questions to any planet.

### Adding More Images
Add PNG or JPG files to the `pics/` directory. They will automatically appear in the HAI SA INVATAM planet.

### Adjusting Difficulty
- **Quiz**: Modify the question database in `quiz_data.gd`
- **Meteorite Game**: Adjust spawn rates and speeds in `scripts/meteorite_dodge.gd`

## License

Educational project for Art Klett textbook materials.
