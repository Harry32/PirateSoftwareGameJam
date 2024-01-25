extends Node


func _ready():
	update_labels()


func _process(_delta):
	update_labels()


func update_labels():
	var totalPeople = ProgressInformation.get_counter("TotalPeople")
	var temporaryConversions = ProgressInformation.get_counter("Temporary")
	var permanentConversions = ProgressInformation.get_counter("Permanent")
	var totalConversions = temporaryConversions + permanentConversions
	var upgradesValues = ProgressInformation.get_counter("Upgrades")
	var clickUpgrade = StatsInformation.get_modifier("Click")
	var actionUpgrade = StatsInformation.get_modifier("Effect")
	var areaUpgrade = StatsInformation.get_modifier("Area")
	var points = ProgressInformation.get_counter("Points")
	var totalPoints = ProgressInformation.get_counter("TotalPoints")

	%PeopleValueLabel.text = str(totalPeople)
	%ConversionsValueLabel.text = str(totalConversions)
	%TemporaryValueLabel.text = str(temporaryConversions)
	%PermanentValueLabel.text = str(permanentConversions)
	%UpgradesValueLabel.text = str(upgradesValues)
	%ClickUpgradeValueLabel.text = str(clickUpgrade)
	%ActionUpgradeValueLabel.text = str(actionUpgrade)
	%AreaUpgradeValueLabel.text = str(areaUpgrade)
	%PointsValueLabel.text = str(points)
	%TotalPointsValueLabel.text = str(totalPoints)
