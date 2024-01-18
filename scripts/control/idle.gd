extends State


@onready var walkingState: State = $"../Walking"
@onready var actionState: State = $"../Action"


func enter():
	animationPlayback.travel("Idle")


func state_physics_process(_delta: float):
	if targetCharacter.targetPosition != targetCharacter.position:
		exit(walkingState)

	if targetCharacter.executeAction:
		exit(actionState)
