extends CharacterBody3D

@export_category("Player Stats")
@export var maxSpeed:float = 12
@export var acceleration:float = 60
@export var friction:float = 50
@export var airFriction:float = 10
@export var jumpForce:float = 8
@export var push:int = 1

@export_category("Mouse Controle")
@export var mouseSensitivity:float = 0.1
@export var controllerSensitivity:float= 3

var gravity = -ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var head = %head

func _unhandled_input(event):
	if event.is_action_pressed("fire"):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	elif event.is_action_pressed("Debug mouse capture"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rotate_y(deg_to_rad(-event.relative.x * mouseSensitivity))
		head.rotate_x(deg_to_rad(-event.relative.y * mouseSensitivity))

func _physics_process(delta):
	var inputVector:Vector3=getInputVector()
	var direction = getDirection(inputVector)
	applyMovement(direction,delta)
	applyFriction(direction,delta)
	applyGravity(delta)
	applyControllerRotation()
	head.rotation.x = clamp(head.rotation.x, deg_to_rad(-85),deg_to_rad(85))
	jump()
	move_and_slide()
	for i in get_slide_collision_count():
		var collision=get_slide_collision(i)
		if(collision.get_collider().is_in_group("bodies")):
			collision.get_collider().apply_central_impulse(-collision.get_normal() * velocity.length() *push)
	
		
	


func getInputVector():
	var inputVector:Vector3
	inputVector.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	inputVector.z = Input.get_action_strength("backward") - Input.get_action_strength("forward")
	return inputVector.normalized() if inputVector.length() > 1 else inputVector

func  getDirection(inputVector):
	var direction = Vector3.ZERO
	direction= (inputVector.x * transform.basis.x) + (inputVector.z * transform.basis.z)
	return direction
	
func applyMovement(direction, delta):
	if direction != Vector3.ZERO:
		velocity.x = velocity.move_toward(direction*maxSpeed,acceleration * delta).x
		velocity.z = velocity.move_toward(direction*maxSpeed,acceleration * delta).z
	
func applyFriction(direction,delta):
	if direction == Vector3.ZERO:
		if is_on_floor():
			velocity= velocity.move_toward(Vector3.ZERO,friction * delta)
		else:
			velocity.x = velocity.move_toward(direction*maxSpeed,airFriction * delta).x
			velocity.z = velocity.move_toward(direction*maxSpeed,airFriction * delta).z

func applyGravity(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		velocity.y = clamp(velocity.y,gravity,jumpForce)
func jump():
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jumpForce
	if Input.is_action_just_released("jump") and velocity.y > jumpForce / 2:
		velocity.y = jumpForce /2

func applyControllerRotation():
	var axisVector = Vector2.ZERO
	axisVector.x = Input.get_action_strength("look right") - Input.get_action_strength("look left")
	axisVector.y = Input.get_action_strength("look down") - Input.get_action_strength("look up")
	if InputEventJoypadMotion:
		rotate_y(deg_to_rad(-axisVector.x) * controllerSensitivity)
		head.rotate_x(deg_to_rad(-axisVector.y) * controllerSensitivity)
