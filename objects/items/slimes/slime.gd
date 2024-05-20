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
	

func point_towards(to):
	var towards = Vector2()
	for item in get_tree().get_nodes_in_group(to):
			if $Area2D.overlaps_body(item):
				towards = self.global_position.direction_to(item.global_position)
	return towards


func _physics_process(delta):
	
	
		


		
	var towards = point_towards("Food")
	
	ai_timer = clamp(ai_timer-delta, 0, ai_timer_max)
	if ai_timer==0:
		if towards == Vector2():
			linear_velocity=(Vector2(randf_range(-1, 1), randf_range(0, 1.5))).normalized()*JUMP_VELOCITY
		else:
			linear_velocity = -(towards+Vector2(randf_range(-1, 1), -0.5)).normalized()*JUMP_VELOCITY
		ai_timer=ai_timer_max

	


