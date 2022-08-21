extends Node2D


signal start


func _on_Start_area_entered(area):
	emit_signal("start")
