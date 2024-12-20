extends CanvasLayer

@onready var color_rect = $ColorRect
@onready var animation_player = $AnimationPlayer

func fadeIn():
	animation_player.play("fade_in")

func fadeOut():
	animation_player.play("fade_out") 
