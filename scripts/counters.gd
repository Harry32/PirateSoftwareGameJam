extends HBoxContainer


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$Temporary/ValueLabel.text = str(ProgressInformation.get_counter("Temporary"))
	$Permanent/ValueLabel.text = str(ProgressInformation.get_counter("Permanent"))
