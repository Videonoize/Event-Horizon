extends State
class_name EnemyFollow

@export var enemy: CharacterBody2D
@export var move_speed := 50.0
@export var audio_streamer : AudioStreamPlayer2D
@export var animation_player : AnimationPlayer
@export var follow_range := 175
var player : CharacterBody2D

#Play scary sound from random time position of file.
func Enter():
	animation_player.play("RESET")
	player = get_tree().get_first_node_in_group("Player")
	var audio_duration = audio_streamer.stream.get_length()
	var random_start_time = randf() * audio_duration
	audio_streamer.play(random_start_time)

#Follow player or transition to patrol state if player is out of range.
func Physics_Update(delta: float):
	var direction := player.global_position - enemy.global_position
	
	if direction.length() < follow_range:
		enemy.velocity = direction.normalized() * move_speed
	else:
		Transitioned.emit(self, "Patrol")

func Exit():
	animation_player.play("fade_out")
	return
