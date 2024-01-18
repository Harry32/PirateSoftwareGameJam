extends Node


@export var quantity: int = 15
@export var meshArea: MeshInstance2D


var rng = RandomNumberGenerator.new()
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
		personInstance.walkableX0 = x0
		personInstance.walkableX1 = x1
		personInstance.walkableY0 = y0
		personInstance.walkableY1 = y1

		$"..".call_deferred("add_child", personInstance)
