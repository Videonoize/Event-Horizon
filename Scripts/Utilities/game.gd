extends Node2D

func _ready():
	SceneTransition.fadeIn()
	AmbientNoise.play()

func fade_out():
	AmbientNoise.stop()
	SceneTransition.fadeOut()
	var bus_index = AudioServer.get_bus_index("SFX")
	AudioServer.set_bus_volume_db(bus_index, -80.0)  #Turn off game sfx volume.
