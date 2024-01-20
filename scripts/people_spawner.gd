extends Node


@export var quantity: int = 15
@export var meshArea: MeshInstance2D


var rng = RandomNumberGenerator.new()
var colors: Array[Color] = [Color(0.74902, 0.607843, 0.376471, 1),
							Color(0.980392, 0.827451, 0.576471, 1),
							Color(0.360784, 0.290196, 0.172549, 1),
							Color(0.188235, 0.145098, 0.0666667, 1)]


const PERSON = preload("res://scenes/person.tscn")


func _ready():
	var x0 = meshArea.mesh.get_aabb().position.x
	var y0 = meshArea.mesh.get_aabb().position.y
	var x1 = x0 + meshArea.mesh.get_aabb().size.x
	var y1 = y0 + meshArea.mesh.get_aabb().size.y
	
	for i in range(quantity):
		var x = rng.randf_range(x0, x1)
		var y = rng.randf_range(y0, y1)

		var personInstance = PERSON.instantiate()
		
		personInstance.position = Vector2(x, y)
		personInstance.personColor = pick_person_color()
		personInstance.walkableX0 = x0
		personInstance.walkableX1 = x1
		personInstance.walkableY0 = y0
		personInstance.walkableY1 = y1

		$"..".call_deferred("add_child", personInstance)
		ProgressInformation.add_counter("TotalPeople")


func pick_person_color() -> Color:
	rng.randomize()
	
	var selectedColor = rng.randi_range(0, colors.size()-1)
	
	return colors[selectedColor];
