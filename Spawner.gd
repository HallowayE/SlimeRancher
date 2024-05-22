extends Node2D


@export var slimes: Array = []


#func _process(delta):
#	for player in get_tree().get_nodes_in_group("Player"):
#		if $Area2D.overlaps_body(player) and len($Area2D.get_overlapping_bodies())<10:
#			var shoot = load(slimes[randi_range(0, len(slimes)-1)]).instantiate()
#			shoot.global_position = self.global_position
#			$"..".add_child.call_deferred(shoot)


func _on_area_2d_body_entered(body):
	for player in get_tree().get_nodes_in_group("Player"):
		if body == player and len($Area2D.get_overlapping_bodies())<10:
			var shoot = load(slimes[randi_range(0, len(slimes)-1)]).instantiate()
			shoot.global_position = self.global_position
			$"..".add_child.call_deferred(shoot)
			
