extends RigidBody2D

var type = "techno"
var techno = "res://generic-items-160-assets_modified_by_seb46/PNG/enemy"


func _ready():
	$Sprite.texture = load(techno + str(randi() % 4) + ".png")
	

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func liberer():
	queue_free()
