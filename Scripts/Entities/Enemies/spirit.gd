extends CharacterBody2D
@onready var animated_sprite = $AnimatedSprite2D

func _physics_process(delta):
	move_and_slide()
	animated_sprite.play("default")
	animated_sprite.flip_h = velocity.x < 0
