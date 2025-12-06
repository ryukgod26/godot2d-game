extends Node2D


var score:int  = 0
@onready var coinslbl: Label = $Player/Coins

func add_point():
	score += 1
	coinslbl.text = "Score: " + str(score)
