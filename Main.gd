extends Node


func _ready():
	add_child(preload("res://Menu.tscn").instance())
	$Menu.connect("start", self, "_on_start")
	
	
func _on_start():
	$Menu.queue_free()
	add_child(preload("res://Jeu.tscn").instance())
	$Jeu.connect("fini", self, "_on_recommencer")
	
	
func _on_recommencer():
	$Jeu.queue_free()
	add_child(preload("res://Menu.tscn").instance())
	$Menu.connect("start", self, "_on_start")
