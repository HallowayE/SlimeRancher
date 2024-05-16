class_name game_object extends RigidBody2D


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
		pass

		
	# Add the gravity.

	gravity_scale=int(grav_on)


	# Handle Jump.


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.

	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)


