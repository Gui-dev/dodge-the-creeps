extends Area2D


export(int) var speed = 400
var screen_size


func _ready() -> void:
  screen_size = get_viewport_rect().size
  

func _process(delta: float) -> void: 
  var velocity := _player_movement()
  
  if velocity.length() > 0:
    velocity = velocity.normalized() * speed
    $animated.play()
  else:
    $animated.stop()
    
  if velocity.x != 0:
    $animated.animation = 'right'
    $animated.flip_v = false
    $animated.flip_h = velocity.x < 0
  if velocity.y != 0:
    $animated.animation = 'up'
    $animated.flip_v = velocity.y > 0
    
  position += velocity * delta
  position.x = clamp(position.x, 0, screen_size.x)
  position.y = clamp(position.y, 0, screen_size.y)


func _player_movement() -> Vector2:  
  var velocity = Vector2.ZERO
  
  if Input.is_action_pressed('ui_right'):
    velocity.x += 1
  if Input.is_action_pressed('ui_left'):
    velocity.x -= 1    
  if Input.is_action_pressed('ui_up'):
    velocity.y -= 1
  if Input.is_action_pressed('ui_down'):
    velocity.y += 1
    
  return velocity