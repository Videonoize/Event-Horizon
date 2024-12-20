extends PointLight2D
@onready var battery = $Battery
@onready var toggleTimer = $ToggleTimer
@onready var onSFX = $OnSFX
@onready var offSFX = $OffSFX

var batteryUI: ProgressBar

func _ready():
	toggleTimer.stop()
	battery.start()
	battery.paused = true
	batteryUI = get_tree().get_first_node_in_group("UI")
	self.enabled = false

func _physics_process(delta):
	look_at(get_global_mouse_position())
	batteryUI.value = battery.time_left
	
	if battery.time_left == 0:
		self.enabled = false
	elif Input.is_action_just_pressed("toggle_flashlight"):
		toggle_flashlight()

#Timer prevents flashlight toggle being spammed.
func toggle_flashlight():
	if toggleTimer.time_left == 0:
		self.enabled = !self.enabled
		toggleTimer.start()
		if self.enabled:
			battery.paused = false
			onSFX.play()
		else:
			battery.paused = true
			offSFX.play()

func fill_battery():
	battery.start()
	if self.enabled:
		battery.paused = false
	else:
		battery.paused = true
