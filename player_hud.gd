extends CanvasLayer


@onready var player = get_tree().get_first_node_in_group("Player")
@onready var tanks = $Tanks/Tank


const TANK_FILLED = 23

func _ready():
	select(0)

func select(num):
	for tank in $Tanks.get_children():
		tank.scale = Vector2(3, 3)
	$Tanks.get_child(num).scale=Vector2(4, 4)


func _process(delta):
	var p_tanks = player.data.tanks
	for i in range(len($Tanks.get_children())):
		$Tanks.get_child(i).get_child(1).scale=Vector2(26, TANK_FILLED*(float(player.data.inventory[i][1])/float(player.data.tank_size)))
		if player.data.inventory[i][0] != null:
			$Tanks.get_child(i).get_child(2).texture = load(player.data.inventory[i][0]+".svg")
		else:
			$Tanks.get_child(i).get_child(2).texture = null


			
	if Input.is_action_pressed("1"):
		select(0)
	if Input.is_action_pressed("2"):
		select(1)
	if Input.is_action_pressed("3"):
		select(2)

	pass
