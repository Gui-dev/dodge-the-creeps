extends RigidBody2D


export(int) var minimum_speed = 150
export(int) var maximum_speed = 300


func _ready() -> void:
  var enemy_types = $animated.frames.get_animation_names()
  $animated.animation = enemy_types[randi() % enemy_types.size()]


func _on_visibility_screen_exited() -> void:
  queue_free()
