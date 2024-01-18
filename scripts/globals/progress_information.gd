extends Node


var counters = {
	"Temporary": 0,
	"Permanent": 0,
	"Total": 0,
	"Points": 0
 }

func add_counter(counter: String, value: int = 1):
	var points = 1
	counters[counter] = counters[counter] + value
	
	if counter == "Permanent":
		points = 5
	
	if value > 0:
		counters["Total"] += 1
		counters["Points"] += points
	
	if counters[counter] < 0:
		counters[counter] = 0

func get_counter(counter: String) -> int:
	return counters[counter]
