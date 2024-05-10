class_name slime extends item


var ai_timer_max = 2
var ai_timer = ai_timer_max - randi() % 5
var dir = Vector2()


func _physics_process(delta):
	if not is_on_floor() and grav_on:
		velocity.y += gravity * delta
		
	
	if is_on_floor():
		velocity.x = move_toward(velocity.x, 0, SPEED)
		ai_timer = clamp(ai_timer-delta, 0, ai_timer_max)
		if ai_timer==0:
			velocity=Vector2(randf_range(-1, 1), randf_range(0, 2)).normalized()*JUMP_VELOCITY
			ai_timer=ai_timer_max
			
	
	move_and_slide()

