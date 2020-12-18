extends Node2D

func _ready():
	pass

#game ends when game timer reaches 0
func _on_GameTimer_timeout():
	game_over()

#game timer starts when game starts
func _on_StartTimer_timeout():
	$GameTimer.start()

#game over state
func game_over():
	pass

#begin game with delay
func new_game():
	$StartTimer.start()
