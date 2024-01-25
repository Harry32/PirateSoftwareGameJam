extends Node


var clickCost: int = 5
var actionCost: int = 5
var areaCost: int = 5


func _ready():
	%ClickValueLabel.text = str(clickCost)
	%ActionValueLabel.text = str(actionCost)
	%AreaValueLabel.text = str(areaCost)
	%PointValueLabel.text = str(ProgressInformation.get_counter("Points"))


func _process(_delta):
	%PointValueLabel.text = str(ProgressInformation.get_counter("Points"))
	
	if ProgressInformation.get_counter("Points") > clickCost:
		%ClickButton.disabled = false
	else:
		%ClickButton.disabled = true
	
	if ProgressInformation.get_counter("Points") > actionCost:
		%ActionButton.disabled = false
	else:
		%ActionButton.disabled = true
	
	if ProgressInformation.get_counter("Points") > areaCost:
		%AreaButton.disabled = false
	else:
		%AreaButton.disabled = true


func _on_click_button_pressed():
	ProgressInformation.add_counter("Points", -clickCost)
	var clickCooldown = StatsInformation.get_stats("Click")
	StatsInformation.set_stats("Click", clickCooldown - (clickCooldown*0.1))
	clickCost *= 2
	%ClickValueLabel.text = str(clickCost)


func _on_action_button_pressed():
	ProgressInformation.add_counter("Points", -actionCost)
	var effectCooldown = StatsInformation.get_stats("Effect")
	StatsInformation.set_stats("Effect", effectCooldown*1.1)
	actionCost *= 2
	%ActionValueLabel.text = str(actionCost)


func _on_area_button_pressed():
	ProgressInformation.add_counter("Points", -areaCost)
	var areaCooldown = StatsInformation.get_stats("Area")
	var particlesLifetime = StatsInformation.get_stats("ParticleLifetime")
	var particlesIV = StatsInformation.get_stats("ParticleIV")
	StatsInformation.set_stats("Area", areaCooldown*1.1)
	StatsInformation.set_stats("ParticleLifetime", particlesLifetime*1.1)
	StatsInformation.set_stats("ParticleIV", particlesIV*1.1)
	areaCost *= 2
	%AreaValueLabel.text = str(areaCost)
