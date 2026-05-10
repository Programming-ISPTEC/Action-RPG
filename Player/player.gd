extends CharacterBody2D

@export_category("MOVEMENT")
@export var ACCELERATION = 500
@export var MAX_SPEED = 80
@export var FRICTION = 500;
@export_category("ROLL")
@export var ROLL_SPEED: float = 125.0

enum State { MOVE, ROLL, ATTACK }

var state = State.MOVE
var player_dir: Vector2 = Vector2.RIGHT

@onready var animationPlayer: AnimationPlayer = $AnimationPlayer
@onready var animationTree: AnimationTree = $AnimationTree
@onready var animationState: AnimationNodeStateMachinePlayback = animationTree.get("parameters/playback")


func _process(delta: float) -> void:
	match state:
		State.MOVE:   _move_state(delta)
		State.ROLL:   _roll_state(delta)
		State.ATTACK: _attack_state(delta)


func _get_input() -> Vector2:
	return Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").normalized()


func _set_blend_position(input: Vector2) -> void:
	for param in ["Idle", "Run", "Roll", "Attack"]:
		animationTree.set("parameters/%s/blend_position" % param, input)


func _move_state(delta: float) -> void:
	var input := _get_input()

	if input != Vector2.ZERO:
		player_dir = input
		_set_blend_position(input)
		animationState.travel("Run")
		velocity = velocity.move_toward(input * MAX_SPEED, ACCELERATION * delta)
	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)

	move_and_slide()

	if Input.is_action_just_pressed("attack"):
		state = State.ATTACK
	if Input.is_action_just_pressed("roll"):
		state = State.ROLL

func _attack_state(_delta: float) -> void:
	velocity = Vector2.ZERO
	animationState.travel("Attack")


func attackAnimationFinished() -> void:
	state = State.MOVE


func _roll_state(_delta: float) -> void:
	var input := _get_input()
	if input != Vector2.ZERO:
		player_dir = input

	animationState.travel("Roll")
	velocity = player_dir * ROLL_SPEED
	move_and_slide()


func rollAnimationFinished() -> void:
	state = State.MOVE