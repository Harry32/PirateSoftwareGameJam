extends CanvasLayer


var clickCost: int = 5
var actionCost: int = 5
var areaCost: int = 5


func _ready():
	%ClickValueLabel.text = str(clickCost)
	%ActionValueLabel.text = str(actionCost)
	%AreaValueLabel.text = str(areaCost)
	%TotalValueLabel.text = str(ProgressInformation.get_counter("Total"))
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
	var areaImageCooldown = StatsInformation.get_stats("AreaImage")
	StatsInformation.set_stats("Area", areaCooldown*1.1)
	StatsInformation.set_stats("AreaImage", areaImageCooldown*1.1)
	areaCost *= 2
	%AreaValueLabel.text = str(areaCost)
