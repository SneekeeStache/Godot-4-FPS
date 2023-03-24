extends Node3D
class_name pistol

@onready var guncast=%gun
@onready var playerAnim=%PlayerAnimator
@onready var camera=%head
@onready var recoilTimer=%recoilTimer
@onready var variables=$"../.."

var cameraPreviousRotation;
var cameraPreviousBool=false

func debug():
	print("pistol")

func shoot():
	playerAnim.speed_scale=variables.shootingSpeedPistol
	if(Input.is_action_just_pressed("fire")):
		playerAnim.play("m1911_shoot")
		
		
			
func bulletshot():
	var tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(camera,"rotation",Vector3(camera.rotation.x+0.05,camera.rotation.y,camera.rotation.z),0.1)
	tween.play()
	if guncast.is_colliding():
		var colliderCast=guncast.get_collider()
		if(colliderCast.is_in_group("hostile")):
			print("pew monstre")
		else:
			print("pew pas monstre")
	else:
		print("pew dans le vide")


	
