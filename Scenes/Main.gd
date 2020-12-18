extends Node2D

#game ends when game timer reaches 0
func _on_GameTimer_timeout():
	game_over()

#game timer starts when game starts
func _on_StartTimer_timeout():
	$GameTimer.start()
	$UpdateTimer.start()

	
func _on_UpdateTimer_timeout():
	$HUD.update_timer($GameTimer.time_left)

#game over state
func game_over():
	$HUD.show_game_over()

#begin game with delay
func new_game():
	$StartTimer.start()
	$HUD.update_timer($GameTimer.time_left)
	$HUD.show_message("Get Ready")


