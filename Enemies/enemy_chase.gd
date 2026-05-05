extends EnemyState
class_name EnemyChase

var move_direction: Vector2

func Physics_update(delta: float):
	if enemy && chasing:
		move_direction = Vector2(target.global_position - enemy.global_position).normalized()
		enemy.velocity = move_direction * MOVE_SPEED
	if !chasing:
		Transitioned.emit(self, "idle")
