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
			var new_texture = Sprite2D.new()
			new_texture.texture = preload("res://icon.svg")
			new_texture.scale=Vector2(0.125, 0.125)
			new_texture.position+=Vector2(0, -23)
			
			$Tanks.get_child(i).add_child(new_texture)
	if Input.is_action_pressed("1"):
		select(0)
	if Input.is_action_pressed("2"):
		select(1)
	if Input.is_action_pressed("3"):
		select(2)

	pass
