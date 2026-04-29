extends Node2D


@onready var q = get_node("AnimatedSprite2D")


func _ready():
	q.play("Animate")

func _on_animated_sprite_2d_animation_finished():
	queue_free()
