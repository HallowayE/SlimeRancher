class_name game_object extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var grav_on = true
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var stuck = false

enum SUCK_STATES{
	SUCKING,
	STUCK,
	SHOOT
}

@onready var col_shape = $CollisionShape2D

func _physics_process(delta):
	for object in get_tree().get_nodes_in_group("Object"):
		if get_last_slide_collision() == object and object.get_last_slide_collision()==self and object!=self:
			col_shape.disabled=true
			object.col_shape.disabled=true
			object.velocity = velocity
			velocity=-velocity
			col_shape.disabled=false
			object.col_shape.disabled=false
		
	# Add the gravity.
	if not is_on_floor() and grav_on:
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
