extends Node


@export var quantity: int = 15
@export var x0: float
@export var y0: float
@export var x1: float
@export var y1: float


var rng = RandomNumberGenerator.new()
const PERSON = preload("res://scenes/person.tscn")


func _ready():
	
	for i in range(quantity):
		var x = rng.randf_range(x0, x1)
		var y = rng.randf_range(y0, y1)
		
		var personInstance = PERSON.instantiate()
		personInstance.position = Vector2(x, y)
		
		$"..".call_deferred("add_child", personInstance)

