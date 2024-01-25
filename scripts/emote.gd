extends Sprite2D


var tween: Tween
var emotes_array: Array[int] = [6, 7, 8, 12, 20, 25]
var rng = RandomNumberGenerator.new()


func show_emote():
	tween = create_tween()
	
	frame = emotes_array[rng.randi_range(0, emotes_array.size()-1)]
	
	rotation = 0.78
	$AnimationPlayer.play("Appearing")

	tween.tween_property(self, "rotation", 0, 1).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)
	$Timer.start()


func hide_emote():
	tween = create_tween()
	
	rotation = 0.0
	$AnimationPlayer.play_backwards("Appearing")

	tween.tween_property(self, "rotation", 0.78, 1).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)


func _on_timer_timeout():
	hide_emote()
