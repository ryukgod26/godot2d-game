extends Node


var score:int = 0
@onready var coinslbl: Label = $"../Player/Coins"



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
func add_point():
	score += 1
	coinslbl.text = "Coins: " + str(score)
