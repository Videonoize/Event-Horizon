extends CharacterBody2D

@export var move_speed : float = 100
@onready var animated_sprite = $AnimatedSprite2D
@onready var all_interactions = []
@onready var flashlight = $Flashlight
@onready var footsteps = $Footsteps
var last_direction = Vector2.ZERO
var footstepsPlaying := false

func _ready():
	animated_sprite.play("idle_down")
	
func _physics_process(_delta):
	var moveDirection = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = moveDirection * move_speed
	update_animation(moveDirection)
	move_and_slide()
	if Input.is_action_just_pressed("interact"):
		execute_interaction()

#Play player movement or idle animation based on input direction.
func update_animation(moveDirection):
	if moveDirection != Vector2.ZERO:
		last_direction = moveDirection
		if moveDirection.x != 0:
			animated_sprite.play("move_side")
		elif moveDirection.y < 0:
			animated_sprite.play("move_up")
		elif moveDirection.y > 0:
			animated_sprite.play("move_down")
		
		if !footstepsPlaying:
			footsteps.play("footsteps")

	else:
		if last_direction.x != 0:
			animated_sprite.play("idle_side")
		elif last_direction.y < 0:
			animated_sprite.play("idle_up")
		elif last_direction.y > 0:
			animated_sprite.play("idle_down")
		footsteps.stop()
	animated_sprite.flip_h = last_direction.x > 0


func _on_interaction_area_area_entered(area):
	all_interactions.insert(0, area)

func _on_interaction_area_area_exited(area):
	all_interactions.erase(area)

func execute_interaction():
	if all_interactions:
		var cur_interaction = all_interactions[0]
		match cur_interaction.interact_type:
			"reach_light" : 
				cur_interaction.on_collect()
				#emit_signal("light_collected")
				flashlight.fill_battery()
