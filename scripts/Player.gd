extends Area2D


export(int) var speed = 400
var screen_size
signal hit


func _ready() -> void:
  self.visible = false
  screen_size = get_viewport_rect().size
  

func _process(delta: float) -> void: 
  var velocity := _player_movement()
  
  if velocity.length() > 0:
    velocity = velocity.normalized() * speed
    $animated.play()
    $particles.emitting = true
  else:
    $animated.stop()
    $particles.emitting = false
    
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


func start(position: Vector2) -> void:
  position = position
  self.visible = true
  $collision.disabled = false


func _on_Player_body_entered(_body: Node) -> void:
  self.visible = false
  emit_signal('hit')
  $collision.set_deferred('disabled', true)
