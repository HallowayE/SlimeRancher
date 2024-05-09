class_name slime extends item

func _physics_process(delta):
	if is_on_floor() and grav_on:
		
