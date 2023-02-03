extends CharacterBody3D

var weapon:int=1

var gravity = -ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var head = %head
@onready var guncast = $head/Camera3d/gun
@onready var shotgunContainer=$head/Camera3d/shotgun
@onready var variables=$variables

func _unhandled_input(event):
	if event.is_action_pressed("fire"):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	elif event.is_action_pressed("Debug mouse capture"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rotate_y(deg_to_rad(-event.relative.x * variables.mouseSensitivity))
		head.rotate_x(deg_to_rad(-event.relative.y * variables.mouseSensitivity))

func _physics_process(delta):
	var inputVector:Vector3=getInputVector()
	var direction = getDirection(inputVector)
	applyMovement(direction,delta)
	applyFriction(direction,delta)
	applyGravity(delta)
	applyControllerRotation()
	match weapon:
		1:
			shootPistol()
		2:
			shootShotgun()
	head.rotation.x = clamp(head.rotation.x, deg_to_rad(-85),deg_to_rad(85))
	jump()
	move_and_slide()
	for i in get_slide_collision_count():
		var collision=get_slide_collision(i)
		if(collision.get_collider().is_in_group("bodies")):
			collision.get_collider().apply_central_impulse(-collision.get_normal() * velocity.length() *variables.push)
	
		

func _ready():
	randomize()
	for shotguncast in shotgunContainer.get_children():
			shotguncast.target_position.x = randf_range(variables.spreadShotgun,-variables.spreadShotgun)
			shotguncast.target_position.y = randf_range(variables.spreadShotgun,-variables.spreadShotgun)

# get player directional input
func getInputVector():
	var inputVector:Vector3
	inputVector.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	inputVector.z = Input.get_action_strength("backward") - Input.get_action_strength("forward")
	return inputVector.normalized() if inputVector.length() > 1 else inputVector

#transform input into a direction
func  getDirection(inputVector):
	var direction = Vector3.ZERO
	direction= (inputVector.x * transform.basis.x) + (inputVector.z * transform.basis.z)
	return direction
	
#apply the direction as a movement in the game
func applyMovement(direction, delta):
	if direction != Vector3.ZERO:
		velocity.x = velocity.move_toward(direction*variables.maxSpeed,variables.acceleration * delta).x
		velocity.z = velocity.move_toward(direction*variables.maxSpeed,variables.acceleration * delta).z
	
#apply friction to movement so that the player still move a little when there is no input
func applyFriction(direction,delta):
	if direction == Vector3.ZERO:
		if is_on_floor():
			velocity= velocity.move_toward(Vector3.ZERO,variables.friction * delta)
		else:
			velocity.x = velocity.move_toward(direction*variables.maxSpeed,variables.airFriction * delta).x
			velocity.z = velocity.move_toward(direction*variables.maxSpeed,variables.airFriction * delta).z

func applyGravity(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		velocity.y = clamp(velocity.y,gravity,variables.jumpForce)
func jump():
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = variables.jumpForce
	if Input.is_action_just_released("jump") and velocity.y > variables.jumpForce / 2:
		velocity.y = variables.jumpForce /2

func applyControllerRotation():
	var axisVector = Vector2.ZERO
	axisVector.x = Input.get_action_strength("look right") - Input.get_action_strength("look left")
	axisVector.y = Input.get_action_strength("look down") - Input.get_action_strength("look up")
	if InputEventJoypadMotion:
		rotate_y(deg_to_rad(-axisVector.x) * variables.controllerSensitivity)
		head.rotate_x(deg_to_rad(-axisVector.y) * variables.controllerSensitivity)

func shootPistol():
	if(Input.is_action_just_pressed("fire")):
		if guncast.is_colliding():
			var colliderCast=guncast.get_collider()
			if(colliderCast.is_in_group("hostile")):
				print("pew monstre")
			else:
				print("pew pas monstre")
		else:
			print("pew dans le vide")
func shootShotgun():
	if(Input.is_action_just_pressed("fire")):
		for shotguncast in shotgunContainer.get_children():
			shotguncast.target_position.x = randf_range(variables.spreadShotgun,-variables.spreadShotgun)
			shotguncast.target_position.y = randf_range(variables.spreadShotgun,-variables.spreadShotgun)
			if shotguncast.is_is_colliding():
				if shotguncast.get_collider().is_in_group("hostile"):
					print("pew monstre")
					

func weaponChange():
	if Input.is_action_just_pressed("weapon 1"):
		weapon=1
	elif Input.is_action_just_pressed("weapon 2"):
		weapon=2
