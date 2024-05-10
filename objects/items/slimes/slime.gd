class_name slime extends item


var ai_timer_max = 2
var ai_timer = ai_timer_max - randi() % 5
var dir = Vector2()
var diet
var fav
var agitation = 0
var hunger = 100

enum STATES{
	ELATED,
	HAPPY,
	HUNGRY,
	AGITATED
}

func _init(given_diet: Array = ["Meat", "Veggi", "Fruit"], fave_food: String = ""):
	diet = given_diet
	fav = fave_food


func _physics_process(delta):
	if not is_on_floor() and grav_on:
		velocity.y += gravity * delta
		
	
	if is_on_floor():
		var towards = Vector2()
		for food in get_tree().get_nodes_in_group("Food"):
			if $Area2D.overlaps_body(food):
				towards = food.global_position-self.global_position
	
		ai_timer = clamp(ai_timer-delta, 0, ai_timer_max)
		if ai_timer==0:
			if towards == Vector2():
				velocity=(Vector2(randf_range(-1, 1), randf_range(0, 1.5))).normalized()*JUMP_VELOCITY
			else:
				velocity = (towards+Vector2(0, -1)).normalized()*JUMP_VELOCITY
			ai_timer=ai_timer_max
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()

