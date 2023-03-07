extends CanvasLayer

signal start_game

func show_message(text):
	$message.text = text
	$message.show()
	$messagetimer.start()
	
func show_game_over():
	show_message('game over')
	#this waits until the message time counts down
	await $messagetimer.timeout
	$message.text = 'dodge the creeps'
	$message.show()
	#one shot timer
	
	await get_tree().create_timer(1.0).timeout
	$startbutton.show()
	
func update_score(score):
	$scorelabel.text = str(score)
	
func update_high_score(score):
	$highscorelabel.text = str(score)
	
func update_total_time(total_time):
	$totaltimelabel.text = str(total_time)

func _on_startbutton_pressed():
	$startbutton.hide()
	start_game.emit()

func _on_messagetimer_timeout():
	$message.hide()


