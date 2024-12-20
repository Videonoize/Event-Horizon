extends AnimationPlayer

@onready var footstep1 = $Footstep1
@onready var footstep2 = $Footstep2
@onready var footstep3 = $Footstep3
@onready var footstep4 = $Footstep4
@onready var footstep5 = $Footstep5
@onready var footstep6 = $Footstep6
var footsteps = []

func _ready():
	footsteps.append(footstep1)
	footsteps.append(footstep2)

#Play random footstep sound from children.
func play_footstep():
	var random_step = randi() %footsteps.size()
	var footstep = footsteps[random_step]
	footstep.pitch_scale = randf_range(0.8, 1.2)
	footstep.play()
