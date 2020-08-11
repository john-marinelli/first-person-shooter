extends Area

enum PickupType {
	Health, 
	Ammo
}

#stats
export(PickupType) var type = PickupType.Health
export var amount : int = 10

#bobbing 
onready var startYPos : float = translation.y
var bobHeight : float = 1.0
var bobSpeed : float = 1.0
var bobbingUp : bool = true

func _process(delta):
	
	#move item up or down
	translation.y += (bobSpeed if bobbingUp == true else -bobSpeed) * delta
	
	#check if item is at the top 
	if bobbingUp and translation.y > startYPos + bobHeight:
		bobbingUp = false
	elif !(bobbingUp) and translation.y < startYPos:
		bobbingUp = true


func _on_Pickup_body_entered(body):
	
	if body.name == "Player":
		pickup(body)
		queue_free()
		
func pickup(player):
	
	if type == PickupType.Health:
		player.add_health(amount)
	elif type == PickupType.Ammo:
		player.add_ammo(amount)
