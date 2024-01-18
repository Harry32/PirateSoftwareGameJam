extends Camera2D


var zoomRate: Vector2 = Vector2(0.1, 0.1)
var speed: float = 500.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var direction = Input.get_vector("Left", "Right", "Up", "Down")
	
	position += direction * speed * delta
	

func _input(event):
	if event.is_action_pressed("Zoom In"):
		if zoom.x < 2:
			zoom += zoomRate

	if event.is_action_pressed("Zoom Out"):
		if zoom.x > 0.1:
			zoom -= zoomRate
