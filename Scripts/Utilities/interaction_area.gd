class_name InteractionArea extends Area2D

@export var interact_type = "none"
@export var interact_value = "none"

var interact: Callable = func():
	pass

func on_collect():
	BulbCounter.collect_bulb()
	self.get_parent().queue_free()
	print("free")
