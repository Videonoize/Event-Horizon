extends CanvasLayer

const READ_RATE = 0.05

@onready var textbox_container = $TextboxContainer
@onready var label = $TextboxContainer/MarginContainer/HBoxContainer/Label

enum State {
	READY,
	READING,
	FINISHED
}

@onready var current_state = State.READY
var tween
@onready var text_queue = []

#Intro text.
func _ready():
	hide_textbox()
	queue_text("This void, a sea of infinites, each darker than the last... (Press 'Enter' to scroll text).")
	queue_text("But you're not the only one here, you know.")
	queue_text("You can't see the others, they hide it within themselves...")
	queue_text("Just like you.")
	queue_text("You wouldn't be the first to drown here.")
	queue_text("But there is another way out...")
	queue_text("It's not too late to escape the event horizon.")
	queue_text("But there is light within reach.")
	queue_text("Collect lights with 'E', and toggle your flashlight with 'LMB'.")
	queue_text("Your flashlights battery will drain over time, but collecting lights will recharge it.")
	queue_text("Watch your step, the void will try to stop you. If your flashlight dies, this place will consume you.")

#Controls printing of characters in the textbox and when the texbox is displayed.
func _process(delta):
	match current_state:
		State.READY:
			label.visible_characters = 0
			if !text_queue.is_empty():
				display_text()
		State.READING:
			if Input.is_action_just_pressed("ui_accept"):
				label.visible_characters = 500
				tween.stop()
				change_state(State.FINISHED)
		State.FINISHED:
			if Input.is_action_just_pressed("ui_accept"):
				change_state(State.READY)
				if text_queue.is_empty():
					hide_textbox()

func queue_text(next_text):
	text_queue.push_back(next_text)

func hide_textbox():
	label.text = ""
	textbox_container.hide()

func show_textbox():
	textbox_container.show()

func display_text():
	tween = create_tween()
	var next_text = text_queue.pop_front()
	label.text = next_text
	change_state(State.READING)
	show_textbox()
	tween.tween_property(label, "visible_characters", len(next_text), len(next_text) * READ_RATE)
	tween.connect("finished", on_tween_finished)
	
func on_tween_finished():
	change_state(State.FINISHED)
	
func change_state(next_state):
	current_state = next_state
	match current_state:
		State.READY:
			pass
		State.READING:
			pass
		State.FINISHED:
			pass
