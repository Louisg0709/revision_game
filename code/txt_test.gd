extends Node2D

@onready var file = 'res://data/test.txt'

var no_lines
var no_questions = 0
var questions : PackedStringArray
var answers : PackedStringArray

func _ready():
	read_questions()
	
	for i in no_questions+1:
		print(questions[i])
		print(answers[i])
		
func read_questions():
	var f = FileAccess.open(file, FileAccess.READ)
	
	var sect_no = 1
	var question_no = 0 
	
	var line_no = 0
	var reading = true
	
	var alternate = true
	while reading:
		var line = f.get_line()
		line_no += 1
		
		if line == "END":
			reading = false
			
		if alternate:
			no_questions+=1
			
		alternate = !alternate

	no_lines = line_no
	
	print(no_questions)
	
	questions.resize(no_questions+1)
	answers.resize(no_questions+1)
	
	line_no = 0
	reading = true
	f.seek(0)
	
	while reading:
		var line = f.get_line() 
		line_no += 1
		if line_no != no_lines: 
			match sect_no:
				1:
					question_no += 1
					sect_no = 2
					questions.set(question_no,line)
				2:
					sect_no = 1
					answers.set(question_no,line)
		else:
			reading = false
			no_questions = question_no
