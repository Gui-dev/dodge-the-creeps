extends Node2D


export(PackedScene) var Enemy
var score


func _ready() -> void:
  randomize()


func new_game() -> void:
  score = 0
  $Player.start($starting_position.position)
  $timer_init.start()
  $HUD.show_message('Prepare-se')
  $HUD.update_score(score)
  $music.play()


func _on_game_over() -> void:
  $score_time.stop()
  $timer_enemy.stop()
  $HUD.game_over()
  $music.stop()
  $sound_death.play()


func _on_timer_init_timeout() -> void:
  $timer_enemy.start()
  $score_time.start()


func _on_score_time_timeout() -> void:
  score += 1
  $HUD.update_score(score)


func _on_timer_enemy_timeout() -> void:
  $enemy_path/spawn_enemy.offset = randi()
  var enemy = Enemy.instance()
  add_child(enemy)
  var direction = $enemy_path/spawn_enemy.rotation + PI / 2
  enemy.position = $enemy_path/spawn_enemy.position
  direction += rand_range(-PI / 4, PI / 4)
  enemy.rotation = direction
  enemy.linear_velocity = Vector2(rand_range(enemy.minimum_speed, enemy.maximum_speed), 0)
  enemy.linear_velocity = enemy.linear_velocity.rotated(direction)
