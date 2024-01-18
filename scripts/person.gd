extends CharacterBody2D


var speed = 150.0
var targetPosition: Vector2
var rng = RandomNumberGenerator.new()
var effect: String = "None"
var executeAction: bool = false
var closePeople: Array[CharacterBody2D]


func _ready():
	targetPosition = position
	$Timer.wait_time = rng.randf_range(0, 5)
	$Timer.start()


func _physics_process(_delta):
		#if walking:
			#rotation = move_toward(rotation, deg_to_rad(newAngle), 0.01)
		#else:
			#rotation = move_toward(rotation, deg_to_rad(newAngle), 0.0018)
		
		#if abs(abs(rotation) - abs(deg_to_rad(newAngle))) <= 0.000001:
			#newAngle = -newAngle
	
	if effect == "Permanent":
		$Label.text = "Permanente"
	if effect == "Temporary":
		$Label.text = "Temporário: " + str(int($EffectTimer.time_left))
	if effect == "None":
		$Label.text = "Normal"

	move_and_slide()

func get_new_target_position():
	var newX = rng.randf_range(0, 1920)
	var newY = rng.randf_range(0, 1080)

	targetPosition = Vector2(newX, newY)

func add_effect(self_effect: bool):
	var perm = 90
	var temp = 50
	if effect == "None":
		if self_effect:
			temp = 0

		var value = rng.randi_range(0, 100)

		if value >= perm:
			effect = "Permanent"
		if value >= temp and value < perm:
			effect = "Temporary"
		if value < temp:
			effect = "None"

		activate_effect()


func cause_effect():
	$Area2D/CPUParticles2D.emitting = true
	
	for person in closePeople:
		person.add_effect(false)


func activate_effect():
	if effect == "Permanent":
		ProgressInformation.add_counter("Permanent")
	
	if effect == "Temporary":
		$EffectTimer.start(StatsInformation.get_stats("Effect"))
		ProgressInformation.add_counter("Temporary")
	
	if effect != "None":
		$ActionTimer.start(rng.randf_range(1, 9))

func update_stats(statsName: String, value: float):
	if statsName == "Area":
		var newScale = Vector2(value, value)
		if $Area2D/CollisionShape2D.scale != newScale:
			$Area2D/CollisionShape2D.scale = newScale

	if statsName == "AreaImage":
		var newScale = Vector2(value, value)
		$Area2D/Sprite2D3.scale = newScale


func _on_timer_timeout():
	get_new_target_position()
	$Timer.start(rng.randf_range(0, 5))


func _on_mouse_entered():
	$Sprite2D2.modulate = Color(1, 1, 1, 1)


func _on_mouse_exited():
	$Sprite2D2.modulate = Color(0, 0, 0, 1)


func _on_input_event(_viewport, event, _shape_idx):
	if event.is_action_pressed("Click") and StatsInformation.is_cooldown_free("Click"):
		add_effect(true)
		executeAction = true
		StatsInformation.start_cooldown("Click")


func _on_effect_timer_timeout():
	effect = "None"
	$Sprite2D.modulate = Color(1, 1, 1, 1)
	$ActionTimer.stop()
	ProgressInformation.add_counter("Temporary", -1)


func _on_area_2d_body_entered(body):
	if body is CharacterBody2D and body != self:
		closePeople.append(body)


func _on_area_2d_body_exited(body):
	if body is CharacterBody2D:
		closePeople.erase(body)


func _on_action_timer_timeout():
	executeAction = true
	$ActionTimer.start(rng.randf_range(1, 9))
