extends CanvasLayer


@onready var player = get_tree().get_first_node_in_group("Player")
@onready var tanks = $Tanks/Tank


const TANK_OFFSET = 40

func create_tank():
	var n_tank = Sprite2D.new()
	n_tank = tanks.duplicate()
	n_tank.scale = Vector2(1, 1)
	$Tanks.add_child(n_tank)
	
func draw_tanks():
	for tank in $Tanks.get_children():
		tanks.remove_child(tank)
	for i in range(int(player.data.tanks)):
		create_tank()
		

func _ready():
	draw_tanks()


func _process(delta):
	var p_tanks = player.data.tanks

	
	for tank in $Tanks.get_children():
		var index = tank.get_index()
		var x = index * TANK_OFFSET
		tank.position = Vector2(x, 0)
		

	pass
