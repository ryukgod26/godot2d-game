extends Control

@onready var healthlbl: Label = $Health/Healthlbl
@onready var coinslbl: Label = $Coins/Coinslbl

func update_coins(val: int):
	coinslbl.text = "Coins: " + str(val)

func update_health(val: int):
	healthlbl.text = "Health: " + str(val)
