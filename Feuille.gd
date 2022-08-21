extends RigidBody2D


var type = "feuille"
var colors = ["yellow", "blue", "brown", "green", "grey", "pink"]
var color = "blue"
var feuille = "res://kenney_foliagesprites_modified_by_seb46/PNG/"


func _ready():
	color = colors[randi() % 6]
	$Sprite.texture = load(feuille + color + str(randi() % 2 + 1) + ".png")
	

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func liberer():
	queue_free()
	
	
func victoire_croissance():
	get_parent().victoire_croissance()
