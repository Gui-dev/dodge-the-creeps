extends CanvasLayer

signal start_game


func show_message(message: String) -> void:
  $message.text = message
  $message.visible = true
  $message_timer.start()
  

func game_over() -> void:
  show_message('Fim de jogo')
  yield($message_timer, 'timeout')
  $message.text = 'Desvie e sobreviva aos monstros'
  $message.visible = true
  yield(get_tree().create_timer(1), 'timeout')
  $button_start.visible = true
  

func update_score(score: int) -> void:
  $score.text = str(score)
  

func _on_button_start_pressed() -> void:
  $button_start.visible = false
  emit_signal('start_game')


func _on_message_timer_timeout() -> void:
  $message.visible = false
