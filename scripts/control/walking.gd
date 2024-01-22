extends State


@onready var idleState: State = $"../Idle"
@onready var actionState: State = $"../Action"
@onready var personNavigationAgent = $"../../PersonNavigationAgent"
@onready var timer = $"../../Timer"


func enter():
	animationPlayback.travel("Walking")


func state_physics_process(_delta: float):
	targetCharacter.direction = Vector2.ZERO
	var velocity = targetCharacter.velocity
	var speed = targetCharacter.speed
	
	if targetCharacter.executeAction:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.y = move_toward(velocity.y, 0, speed)
		
		exit(actionState)
	else:
		if (targetCharacter.position - personNavigationAgent.target_position).abs() < Vector2(1.5, 1.5):
			targetCharacter.position = personNavigationAgent.target_position
			timer.start(targetCharacter.rng.randf_range(0, 5))
			exit(idleState)

		if personNavigationAgent.target_position != targetCharacter.position:
			targetCharacter.direction = targetCharacter.position.direction_to(personNavigationAgent.get_next_path_position())

		if targetCharacter.direction:
			velocity = targetCharacter.direction * speed
		else:
			velocity.x = move_toward(velocity.x, 0, speed)
			velocity.y = move_toward(velocity.y, 0, speed)

	targetCharacter.velocity = velocity
