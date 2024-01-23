extends Node

const SAVE_PATH = "res://savegame.bin"

func saveGame():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE) 
	
	var data: Dictionary = {
		"playerHP": Game.playerHP,
		"gold" : Game.Gold
	}
	
	var jstr = JSON.stringify(data)
	
	file.store_line(jstr)
	
func loadGame():
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if(FileAccess.file_exists(SAVE_PATH) == true):
		if not file.eof_reached():
			var currentline = JSON.parse_string(file.get_line())
			if currentline:
				var HP = float(currentline["playerHP"])
				Game.playerHP = HP if HP > 0 else 5
				Game.Gold = float(currentline["gold"])
