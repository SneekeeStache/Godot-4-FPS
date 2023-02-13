extends Node3D
class_name shotgun

@onready var shotgunContainer=%shotguncast
@onready var variables=$"../.."
# Called when the node enters the scene tree for the first time.
func debug():
	print("shotgun")

func shoot():
	if(Input.is_action_just_pressed("fire")):
		for shotguncast in shotgunContainer.get_children():
			shotguncast.target_position.x = randf_range(variables.spreadShotgun,-variables.spreadShotgun)
			shotguncast.target_position.y = randf_range(variables.spreadShotgun,-variables.spreadShotgun)
			if shotguncast.is_colliding():
				if shotguncast.get_collider().is_in_group("hostile"):
					print("pew monstre")
				else:
					print("pew pas monstre")
			else:
				print("pew dans le vide")
