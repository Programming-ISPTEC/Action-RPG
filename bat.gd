extends CharacterBody2D
@export var look_pos = Vector2(1,0);
func _physics_process(delta: float) -> void:
	move_and_slide()
	if velocity.length() > 0:
		$AnimationPlayer.play("fly")
		
	if velocity.x > 0:
		$Sprite2D.flip_h = false
		
	else:
		$Sprite2D.flip_h = true
		
	
