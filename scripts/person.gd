extends CharacterBody2D

@export var aaa: Color = Color(0.1882, 0.1451, 0.0667, 1)
@export var bbb: Color = Color(0.749, 0.6078, 0.3765, 1)

var speed = 150.0
var targetPosition: Vector2
var rng = RandomNumberGenerator.new()
var effect: String = "None"
var executeAction: bool = false
var closePeople: Array[CharacterBody2D]
var direction: Vector2
var personColor: Color
var walkableX0: float
var walkableX1: float
var walkableY0: float
var walkableY1: float


func _ready():
	direction = Vector2.ZERO
	targetPosition = position
	
	$PersonSprite.material.set_shader_parameter("newColor", personColor)
	
	StatsInformation.connect("change_stats",update_stats)
	
	$Timer.wait_time = rng.randf_range(0, 5)
	$Timer.start()


func _physics_process(_delta):
	if effect == "Permanent":
		$Label.text = "Permanente"
	if effect == "Temporary":
		$Label.text = "Temporário: " + str(int($EffectTimer.time_left))
	if effect == "None":
		$Label.text = "Normal"

	update_facing_direction()
	move_and_slide()


func update_facing_direction():
	if direction != Vector2.ZERO:
		$PersonSprite.flip_h = velocity.x > 0


func get_new_target_position():
	#var newX = rng.randf_range(walkableX0, walkableX1)
	#var newY = rng.randf_range(walkableY0, walkableY1)
	var v1 = rng.randfn(0, 300)
	var v2 = rng.randfn(0, 300)
	
	var newX = clamp(position.x + v1, -6000, 6000)
	var newY = clamp(position.y + v2, -6000, 6000)
	
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

		activate_effect(self_effect)


func cause_effect():
	$EffectArea/ActionParticles.emitting = true
	
	for person in closePeople:
		person.add_effect(false)


func activate_effect(self_effect: bool):
	if effect == "Permanent":
		ProgressInformation.add_counter("Permanent")
	
	if effect == "Temporary":
		$EffectTimer.start(StatsInformation.get_stats("Effect"))
		ProgressInformation.add_counter("Temporary")
	
	if effect != "None":
		$ActionTimer.start(rng.randf_range(1, 9))
		
		if not self_effect:
			$EffectArea/EffectParticles.emitting = true

func update_stats(statsName: String, value: float):
	if statsName == "Area":
		var newScale = Vector2(value, value)
		if $EffectArea/CollisionShape2D.scale != newScale:
			$EffectArea/CollisionShape2D.scale = newScale

	if statsName == "ParticleLifetime":
		$EffectArea/ActionParticles.lifetime = value

	if statsName == "ParticleIV":
		$EffectArea/ActionParticles.initial_velocity_min = value
		$EffectArea/ActionParticles.initial_velocity_max = value


func _on_timer_timeout():
	get_new_target_position()
	$Timer.start(rng.randf_range(0, 5))


func _on_mouse_entered():
	$PersonSprite.material.set_shader_parameter("showBorder", true)


func _on_mouse_exited():
	$PersonSprite.material.set_shader_parameter("showBorder", false)


func _on_input_event(_viewport, event, _shape_idx):
	if event.is_action_pressed("Click") and StatsInformation.is_cooldown_free("Click"):
		add_effect(true)
		executeAction = true
		StatsInformation.start_cooldown("Click")


func _on_effect_timer_timeout():
	effect = "None"
	$PersonSprite.modulate = Color(1, 1, 1, 1)
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
