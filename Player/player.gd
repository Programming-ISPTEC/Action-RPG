extends CharacterBody2D

@export_category("MOVEMENT")
@export var ACCELERATION = 500
@export var MAX_SPEED = 80
@export var FRICTION = 500;
	
enum movimento {
	MOVE,
	ROLL,
	ATTACK
}

var state = movimento.MOVE

@onready var animationPlayer = get_node("AnimmationPlayer")
@onready var animationTree = get_node("AnimationTree")

@onready var animationState = animationTree.get("parameters/playback") as AnimationNodeStateMachinePlayback

func _process(delta: float) -> void:
	match state:
		0:
			moveState(delta);
		1:
			rollState(delta)
		2:
			attackState(delta);

func moveState(delta) -> void:
	var x = Vector2.ZERO
	x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left");
	var y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up");
	var input = Vector2(x, y);
	input = input.normalized();

	if (input != Vector2.ZERO):
		animationTree.set("parameters/Idle/blend_position", input);
		
		animationTree.set("parameters/Run/blend_position", input);
		
		animationTree.set("parameters/Roll/blend_position", input);
		
		animationTree.set("parameters/Attack/blend_position", input);

		animationState.travel("Run");
		
		velocity = velocity.move_toward(input * MAX_SPEED, ACCELERATION * delta);
	else:
		animationState.travel("Idle");
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta);

	move_and_slide();

	if (Input.is_action_just_pressed("attack")):
		state = movimento.ATTACK
	if (Input.is_action_just_pressed("ui_accept")):
		state = movimento.ROLL

func attackState(delta) -> void:
	##velocity = Vector2.ZERO;
	animationState.travel("Attack");
	
func attackAnimationFinished() -> void:
	state = movimento.MOVE;


func rollState(delta) -> void:
	var x = Vector2.ZERO
	x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left");
	var y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up");
	var input = Vector2(x, y);
	input = input.normalized();
	
	animationState.travel("Roll");
	

func _on_animation_tree_finished(Roll):
	print("Entrou")
	state = movimento.MOVE;
