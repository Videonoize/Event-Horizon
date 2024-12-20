extends PointLight2D

@onready var animated_sprite = $AnimatedSprite2D

func _physics_process(delta):
	animated_sprite.play("default")
