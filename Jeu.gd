extends Node


signal fini


export(PackedScene) var nourriture
export(PackedScene) var ennemi
var son = "res://sci-fi-sounds_modified_by_seb_46/Audio/"


func _ready():
	randomize()
	new_game()


func new_game():
	$StartTimer.start()


func _on_StartTimer_timeout():
	$FeuillesTimer.start()
	$TechnoTimer.start()


func _on_FeuillesTimer_timeout():
	var nour = nourriture.instance()
	var nour_location = $CheminFeuilles/DepartDesFeuilles
	nour_location.offset = randi()
	
	var direction = nour_location.rotation + PI / 2
	nour.position = nour_location.position
	direction += rand_range(-PI / 4, PI / 4)
	nour.rotation = direction
	var velocity = Vector2(rand_range(150.0, 250.0), 0.0)
	nour.linear_velocity = velocity.rotated(direction)
	
	add_child(nour)


func _on_TechnoTimer_timeout():
	var en = ennemi.instance()
	var en_location = $CheminFeuilles/DepartDesFeuilles
	en_location.offset = randi()
	
	var direction = en_location.rotation + PI / 2
	en.position = en_location.position
	direction += rand_range(-PI / 4, PI / 4)
	en.rotation = direction
	var velocity = Vector2(rand_range(150.0, 250.0), 0.0)
	en.linear_velocity = velocity.rotated(direction)
	
	add_child(en)


func _on_Player_victoire_croissance():
	print("victoire")
	
	
func victoire_croissance():
	$Player.speed = 0
	$Player.position.x = 400
	$Player.position.y = 300
	$Player.scale.x = 2
	$Player.scale.y = 2
	yield(get_tree().create_timer(1),"timeout")
	$FeuillesTimer.queue_free()
	$TechnoTimer.queue_free()
	yield(get_tree().create_timer(4),"timeout")
	emit_signal("fini")


func _on_Decompte_fini():
	$Son.stream = load(son + "timesup.wav")
	$Son.play()
	get_tree().call_group("tetes", "explosion")
	yield(get_tree().create_timer(4),"timeout")
	$FeuillesTimer.queue_free()
	$TechnoTimer.queue_free()
	yield(get_tree().create_timer(1),"timeout")
	
	emit_signal("fini")
