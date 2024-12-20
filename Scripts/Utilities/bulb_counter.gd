extends Node

var total_bulbs = 0
var collected_bulbs = 0
@onready var sound1 = LightPickupSounds.get_child(0)
@onready var sound2 = LightPickupSounds.get_child(1)
@onready var sound3 = LightPickupSounds.get_child(2)
@onready var sound4 = LightPickupSounds.get_child(3)
@onready var sound5 = LightPickupSounds.get_child(4)
@onready var sound6 = LightPickupSounds.get_child(5)
var pickupsounds = []

func _ready():
	total_bulbs = 6
	collected_bulbs = 0
	pickupsounds.append(sound1)
	pickupsounds.append(sound2)
	pickupsounds.append(sound3)
	pickupsounds.append(sound4)
	pickupsounds.append(sound5)
	pickupsounds.append(sound6)

#Each bulb collected plays a unique musical flourish, also displays last textbox message.
func collect_bulb():
	pickupsounds[collected_bulbs].play()
	collected_bulbs += 1
	if collected_bulbs == total_bulbs:
		Game.fade_out()
		Textbox.queue_text("No matter how dark your void may seem, no matter how dim it may be, there is always a light to be found in this world and hold onto.")
	else:
		Textbox.queue_text(str((total_bulbs - collected_bulbs), " lights left."))
