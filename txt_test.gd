extends Node2D

@onready var file = 'res://data/test.txt'

var no_questions
var questions
var answers

func _ready():
	var f = FileAccess.open(file, FileAccess.READ)
	
	var line_no = 0
	var sect_no = 1
	
	var reading = true
	while reading:
		var line = f.get_line() 
		if line != "END":
			line_no += 1
			
			match sect_no:
				1:
					sect_no = 2
					questions[line_no]=line
				2:
					sect_no = 1
					answers[line_no-1]=line
		else:
			reading = false
			no_questions = (line_no - 1)/2
