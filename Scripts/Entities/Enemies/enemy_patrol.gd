extends State
class_name  EnemyPatrol

var idleT : Timer
@export var enemy: CharacterBody2D
@export var move_speed := 25.0
@export var spot_range := 150
var player: CharacterBody2D

var move_direction : Vector2
var wander_time : float

func randomize_wander():
	move_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	wander_time = randf_range(1, 3)

func Enter():
	player = get_tree().get_first_node_in_group("Player")
	randomize_wander()

func Update(delta: float):
	if wander_time > 0:
		wander_time -= delta
	else:
		randomize_wander()

func Physics_Update(delta: float):
	if enemy:
		enemy.velocity = move_direction * move_speed
	
	var direction = player.global_position - enemy.global_position
	
	#Only perform raycast if player is within enemies range.
	if direction.length() <= spot_range:
		var space_state = enemy.get_world_2d().direct_space_state
		var raycast_params = PhysicsRayQueryParameters2D.new()
		raycast_params.from = enemy.global_position
		raycast_params.to = player.global_position
		raycast_params.exclude = [enemy]

		# Perform raycast.
		var raycast_result = space_state.intersect_ray(raycast_params)

		# Check if the ray hits player.
		if !raycast_result or raycast_result.collider == player:
			Transitioned.emit(self, "Follow")
		
func Exit():
	return
