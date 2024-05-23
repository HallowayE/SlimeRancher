extends Node2D


@export var slimes: Array = []


func _process(delta):
	for player in get_tree().get_nodes_in_group("Player"):
		if $PlayerDetection.overlaps_body(player) and len($SlimeDetection.get_overlapping_bodies())<10:
			print("entered")
			var shoot = load(slimes[randi_range(0, len(slimes)-1)]).instantiate()
			shoot.global_position = self.global_position
			$"../..".add_child.call_deferred(shoot)


func _on_area_2d_body_entered(body):
	pass
#	for player in get_tree().get_nodes_in_group("Player"):
#		if body == player and len($Area2D.get_overlapping_bodies())<10:
#			print("entered")
#			var shoot = load(slimes[randi_range(0, len(slimes)-1)]).instantiate()
#			shoot.global_position = self.global_position
#			$"../..".add_child.call_deferred(shoot)
			
