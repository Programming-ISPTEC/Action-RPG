extends State
class_name EnemyState
@export_category("Enemy / Self ")
@export var enemy: CharacterBody2D
@export var detectionArea: Area2D
@export var target: CharacterBody2D 
@export var MOVE_SPEED : float = 40.0
@export var chasing: bool = false

func _ready():
	enemy = get_node("../..")
	detectionArea =  enemy.get_node("detection_area")
	target = get_tree().get_first_node_in_group("player")
	if detectionArea:
		print(detectionArea)
		detectionArea.body_entered.connect(_on_body_entered)
		detectionArea.body_exited.connect(_on_body_exit) 
func _on_body_entered(body: Node2D):
	print("Algo Entrou")
	chasing = true
	
func _on_body_exit(body: Node2D):
	print("Algo Saiu")
	chasing = false
	
