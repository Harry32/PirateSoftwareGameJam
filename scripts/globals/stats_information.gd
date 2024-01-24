extends Node

signal activate_cooldown(targetName: String)
signal change_stats(targetName: String, value: float)

var cooldowns = { "Click": 0.0 }
var stats = { "Click": 15, "Area": 15.0, "ParticleLifetime": 0.9, "ParticleIV": 150, "Effect": 10.0 }
var stats_modifiers = { "Click": 0.0, "Area": 0.0, "ParticleLifetime": 0.0, "ParticleIV": 0.0, "Effect": 0.0 }


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
	var modifier = 1.0 + (stats_modifiers[statsName]/100)

	return stats[statsName] * modifier


func set_stats(statsName: String, value: float):
	if value >= 0:
		stats[statsName] = value
		change_stats.emit(statsName, value)


func get_modifier(modifierName: String) -> float:
	return stats_modifiers[modifierName]
