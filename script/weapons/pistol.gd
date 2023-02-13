extends Node3D
class_name pistol

@onready var guncast=%gun

func debug():
	print("pistol")

func shoot():
	if(Input.is_action_just_pressed("fire")):
		if guncast.is_colliding():
			var colliderCast=guncast.get_collider()
			if(colliderCast.is_in_group("hostile")):
				print("pew monstre")
			else:
				print("pew pas monstre")
		else:
			print("pew dans le vide")
