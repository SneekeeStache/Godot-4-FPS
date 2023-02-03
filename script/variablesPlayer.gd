@tool
extends Node3D

var maxSpeed:float = 12
var acceleration:float = 60
var friction:float = 50
var airFriction:float = 10
var jumpForce:float = 8
var push:int = 1

var damagePistol:float=20
var spreadPistol:float=10
var recoilPistol:float=10

var damageShotgun:float=10
var spreadShotgun:float=10
var recoilShotgun:float=10

var mouseSensitivity:float = 0.1
var controllerSensitivity:float= 3
# Called when the node enters the scene tree for the first time.
func _get(property):
	if property == 'playerStats/maxSpeed': return maxSpeed
	if property == 'playerStats/acceleration': return acceleration
	if property == 'playerStats/friction': return friction
	if property == 'playerStats/airFriction': return airFriction
	if property == 'playerStats/jumpForce': return jumpForce
	if property == 'playerStats/push': return push
	
	if property == 'weaponStats/pistol/damage': return damagePistol
	if property == 'weaponStats/pistol/spread': return spreadPistol
	if property == 'weaponStats/pistol/recoil': return recoilPistol
	
	if property == 'weaponStats/shotgun/damage': return damageShotgun
	if property == 'weaponStats/shotgun/spread': return spreadShotgun
	if property == 'weaponStats/shotgun/recoil': return recoilShotgun
	
	if property == 'mouseControle/mouseSensitivity': return mouseSensitivity
	if property == 'mouseControle/controllerSensitivity': return controllerSensitivity
	
	

func _set(property,value):
	if property == 'playerStats/maxSpeed': maxSpeed = value
	if property == 'playerStats/acceleration': acceleration = value
	if property == 'playerStats/friction': friction = value
	if property == 'playerStats/airFriction': airFriction = value
	if property == 'playerStats/jumpForce': airFriction = value
	if property == 'playerStats/push': push = value
	
	if property == 'weaponStats/pistol/damage': damagePistol = value
	if property == 'weaponStats/pistol/spread': spreadPistol = value
	if property == 'weaponStats/pistol/recoil': recoilPistol = value
	
	if property == 'weaponStats/shotgun/damage': damageShotgun = value
	if property == 'weaponStats/shotgun/spread': spreadShotgun = value
	if property == 'weaponStats/shotgun/recoil': recoilShotgun = value
	
	if property == 'mouseControle/mouseSensitivity': mouseSensitivity = value
	if property == 'mouseControle/controllerSensitivity': controllerSensitivity = value
	
	

func _get_property_list() -> Array:
	var props = []
	props.append(
		{
			'name': 'playerStats/maxSpeed',
			'type': TYPE_FLOAT
		}
	)
	props.append(
		{
			'name': 'playerStats/acceleration',
			'type': TYPE_FLOAT
		}
	)
	
	props.append(
		{
			'name': 'playerStats/friction',
			'type': TYPE_FLOAT
		}
	)
	
	props.append(
		{
			'name': 'playerStats/airFriction',
			'type': TYPE_FLOAT
		}
	)
	
	props.append(
		{
			'name': 'playerStats/jumpForce',
			'type': TYPE_FLOAT
		}
	)
	
	props.append(
		{
			'name': 'playerStats/push',
			'type': TYPE_INT
		}
	)
	
	props.append(
		{
			'name': 'weaponStats/pistol/damage',
			'type': TYPE_FLOAT
		}
	)
	props.append(
		{
			'name': 'weaponStats/pistol/spread',
			'type': TYPE_FLOAT
		}
	)
	props.append(
		{
			'name': 'weaponStats/pistol/recoil',
			'type': TYPE_FLOAT
		}
	)
	props.append(
		{
			'name': 'weaponStats/shotgun/damage',
			'type': TYPE_FLOAT
		}
	)
	props.append(
		{
			'name': 'weaponStats/shotgun/spread',
			'type': TYPE_FLOAT
		}
	)
	props.append(
		{
			'name': 'weaponStats/shotgun/recoil',
			'type': TYPE_FLOAT
		}
	)
	props.append(
		{
			'name': 'mouseControle/mouseSensitivity',
			'type': TYPE_FLOAT
		}
	)
	props.append(
		{
			'name': 'mouseControle/controllerSensitivity',
			'type': TYPE_FLOAT
		}
	)
	return props
