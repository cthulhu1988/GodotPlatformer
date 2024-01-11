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
				Game.playerHP = float(currentline["playerHP"])
				Game.Gold = float(currentline["gold"])
