extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var gravity_on = true

var menu_scene = preload("res://my_gui.tscn")
var menu_instance = null



var stuck = false

@onready var p_HUD = get_tree().get_first_node_in_group("HUD")

@export var data = {
	"max_health": 100.0,
	"health": 100,
	"energy": 100,
	"money": 0,
	"tanks": 3,
	"tank_size": 25,
	"secondaries": [],
	"inventory": [],
}

func _ready():
	p_HUD.show()
	menu_instance=menu_scene.instantiate()
	$Camera2D.add_child.call_deferred(menu_instance)
	menu_instance.hide()
	for i in range(data.tanks):
		data.inventory.append([null, 0])
	
	

func gun_physics():
	$Mouse.position=get_local_mouse_position()
	$RayCast2D.target_position=get_local_mouse_position()
	
	for object in get_tree().get_nodes_in_group("Object"):
		var dis = self.global_position.distance_to(object.global_position)
		
		if $Mouse.overlaps_body(object) and Input.is_action_just_pressed("right"):
			object.grav_on = false
			
		if (($RayCast2D.is_colliding() and $RayCast2D.get_collider()==object) or $Mouse.overlaps_body(object)) and Input.is_action_pressed("right"):
			dis = move_toward(dis, 0.0, 2)
			object.global_position=self.global_position+(self.global_position.direction_to(get_global_mouse_position())*dis)
			if dis < 25:
				if object.is_in_group("Item"):
					for i in data.inventory:
						if i[0] == null or i[0] == object.get_scene_file_path():
							i[0]=object.get_scene_file_path()
							object.queue_free()
							i[1]+=1
							print(data.inventory)
							break
					object.grav_on = true
				else:
					stuck = true
					object.stuck = true
		if object.stuck:
			object.grav_on=false
			object.global_position=self.global_position+(self.global_position.direction_to(get_global_mouse_position())*25)
			object.col_shape.disabled= true
			if Input.is_action_just_pressed("left"):
				object.stuck=false
				stuck = false
				object.col_shape.disabled= false
				object.grav_on=true
				object.linear_velocity = self.global_position.direction_to(object.global_position)*500
				
			
		if (Input.is_action_just_released("right") or !$Mouse.overlaps_body(object) and !($RayCast2D.is_colliding() and $RayCast2D.get_collider()==object)) and object.col_shape.disabled == false:
			object.grav_on = true
			


func _physics_process(delta):
	gun_physics()
	if Input.is_action_just_pressed("ui_cancel"):
		menu_instance.show()
		get_tree().paused = true
	
	# Add the gravity.
	if not is_on_floor() and gravity_on:
		velocity.y += gravity * delta
		
	
	
	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			velocity.y = JUMP_VELOCITY

			

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("a", "d")
	
	update_anim(direction)  # Update animation based on state

	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if Input.is_action_just_pressed("ui_cancel"):  # Escape
		gravity_on = not gravity_on
	
	move_and_slide()
	$Camera2D.position=($Mouse.position)/5


@onready var anim = $AnimatedSprite2D
@onready var gun = $Sprite2D


func update_anim(direction):
	gun.flip_h=get_local_mouse_position().x<0
	anim.flip_h=get_local_mouse_position().x<0
	if not is_on_floor() and velocity.y<0:
		anim.play("jump")
	elif not is_on_floor():
			anim.play("fall")
	elif direction != 0 and velocity.x != 0:
		anim.play("walk")
	else:
		anim.play("default")
	if get_local_mouse_position().y>10:
		gun.frame=15
	elif get_local_mouse_position().y<-10:
		gun.frame=17
	else:
		gun.frame=16
	
