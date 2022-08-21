extends Control

signal fini


onready var timer = get_node("TimerDecompte")
onready var temps = get_node("Texte")


func _process(_delta):
	temps.text = str(round(timer.time_left)) + " s"


func _on_TimerDecompte_timeout():
	emit_signal("fini")
	hide()
