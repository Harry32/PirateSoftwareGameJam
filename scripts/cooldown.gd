extends ProgressBar

var tween: Tween

func _ready():
	StatsInformation.connect("activate_cooldown", activate_cooldown)


func _process(_delta):
	if value > 0:
		$Label.text = str(int(StatsInformation.get_cooldown("Click"))) + "s"

func activate_cooldown(targetName: String):
	if targetName == "Click":
		var cooldown_time = StatsInformation.get_stats("Click")
		value = 100
		
		if tween:
			tween.kill()
	
		tween = get_tree().create_tween().set_parallel(true)
		tween.tween_property(self, "value", 0, cooldown_time)
		tween.tween_method(update_cooldown, cooldown_time, 0.0, cooldown_time)


func update_cooldown(cooldown_value: float):
	StatsInformation.set_cooldown("Click", cooldown_value)
