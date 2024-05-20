extends CanvasLayer


@onready var player = get_tree().get_first_node_in_group("Player")
@onready var tanks = $Tanks/Tank


const TANK_FILLED = 23


func _process(delta):
	var p_tanks = player.data.tanks
	for i in range(len($Tanks.get_children())):
		$Tanks.get_child(i).get_child(1).scale=Vector2(26, TANK_FILLED*(float(player.data.inventory[i][1])/float(player.data.tank_size)))
		if player.data.inventory[i][0] != null:
			$Tanks.get_child(i).add_child(player.data.inventory[i][0])

	pass
