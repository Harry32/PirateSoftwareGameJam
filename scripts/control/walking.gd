extends State


@onready var idleState: State = $"../Idle"
@onready var actionState: State = $"../Action"


func enter():
	animationPlayback.travel("Walking")


func state_physics_process(_delta: float):
	var direction = Vector2.ZERO
	var velocity = targetCharacter.velocity
	var speed = targetCharacter.speed
	
	if targetCharacter.executeAction:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.y = move_toward(velocity.y, 0, speed)
		
		exit(actionState)
	else:
		if (targetCharacter.position - targetCharacter.targetPosition).abs() < Vector2(1.5, 1.5):
			targetCharacter.position = targetCharacter.targetPosition
			exit(idleState)

		if targetCharacter.targetPosition != targetCharacter.position:
			direction = targetCharacter.position.direction_to(targetCharacter.targetPosition)

		if direction:
			velocity = direction * speed
		else:
			velocity.x = move_toward(velocity.x, 0, speed)
			velocity.y = move_toward(velocity.y, 0, speed)

	targetCharacter.velocity = velocity
