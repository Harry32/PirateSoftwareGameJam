extends CanvasLayer


var tabsScenes: Array[PackedScene] = [
	preload("res://scenes/ui/shop_menu.tscn"),
	preload("res://scenes/ui/stats_menu.tscn"),
	preload("res://scenes/ui/controls_menu.tscn"),
	preload("res://scenes/ui/config_menu.tscn")
]


func _ready():
	%ContentContainer.call_deferred("add_child", tabsScenes[0].instantiate())


func change_tab(tab: int):
	%ContentContainer.get_child(0).queue_free()
	%ContentContainer.call_deferred("add_child", tabsScenes[tab].instantiate())


func _on_tab_bar_tab_changed(tab):
	change_tab(tab)
