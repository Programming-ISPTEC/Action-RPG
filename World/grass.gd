extends Node2D

func create_grass_effect():
	var grass_effect = load("res://Effects/grass_efect.tscn")

	var grass_effect_instance = grass_effect.instantiate() as Node2D

	var world = get_tree().current_scene
	world.add_child(grass_effect_instance)

	grass_effect_instance.global_position = global_position
	

func on_hurt_box_area_entered(area): 
	create_grass_effect()
	queue_free()
