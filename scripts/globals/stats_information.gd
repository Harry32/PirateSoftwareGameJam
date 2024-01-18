extends Node

signal activate_cooldown(targetName: String)
signal change_stats(targetName: String, value: float)

var cooldowns = { "Click": 0.0 }
var stats = { "Click": 15, "Area": 15.0, "AreaImage": 5, "Effect": 10.0 }


func set_cooldown(cooldownName: String, value: float):
	if value >= 0:
		cooldowns[cooldownName] = value


func get_cooldown(cooldownName: String) -> float:
	return cooldowns[cooldownName]


func start_cooldown(cooldownName: String):
	cooldowns[cooldownName] = stats[cooldownName]
	activate_cooldown.emit(cooldownName)


func is_cooldown_free(cooldownName: String):
	return cooldowns[cooldownName] == 0.0


func get_stats(statsName: String) -> float:
	return stats[statsName]


func set_stats(statsName: String, value: float):
	if value >= 0:
		stats[statsName] = value
		change_stats.emit(statsName, value)
