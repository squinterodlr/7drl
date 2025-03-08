class_name Player extends Actor

func _input(event):
	if event.is_action_pressed("rotate_ccw"):
		heading = (heading + 1) % 8 as Heading
	elif event.is_action_pressed("rotate_cw"):
		heading = (heading - 1) % 8 as Heading
		if heading < 0:
			heading = heading + 8 as Heading
	elif event.is_action_pressed("move_forward"):
		move(false)
	elif event.is_action_pressed("move_backward"):
		move(true)
