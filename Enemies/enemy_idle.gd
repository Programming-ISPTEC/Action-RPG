extends EnemyState
class_name Enemy_idle

var move_direction: Vector2
var wander_time: float

func _randomize_wander() -> void:
	move_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	wander_time = randf_range(1, 3)

func Enter():
	_randomize_wander()

func Update(delta: float):
	if wander_time > 0:
		wander_time -= delta
	else:
		_randomize_wander()

func Physics_update(_delta: float):
	if enemy && !chasing:
		enemy.velocity = move_direction * MOVE_SPEED
	if chasing:
		Transitioned.emit(self,"chase")
