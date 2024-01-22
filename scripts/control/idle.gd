extends State


@onready var walkingState: State = $"../Walking"
@onready var actionState: State = $"../Action"
@onready var personNavigationAgent = $"../../PersonNavigationAgent"


func enter():
	animationPlayback.travel("Idle")


func state_physics_process(_delta: float):
	if personNavigationAgent.target_position != targetCharacter.position:
		exit(walkingState)

	if targetCharacter.executeAction:
		exit(actionState)
