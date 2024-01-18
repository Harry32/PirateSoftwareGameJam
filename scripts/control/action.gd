extends State


@onready var idleState: State = $"../Idle"
@onready var walkingState: State = $"../Walking"


func enter():
	animationPlayback.travel("Action")


func _on_animation_tree_animation_finished(anim_name):
	if anim_name == "Action":
		targetCharacter.executeAction = false

		if targetCharacter.targetPosition != targetCharacter.position:
			exit(walkingState)
		else:
			exit(idleState)
