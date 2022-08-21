extends Area2D


var self_color = "yellow"
var number_color = 0
var next_colors = {"blue": 0, "brown": 0, "green": 0, "grey": 0, "pink": 0}
var evol0 = "res://kenney_animalpackredux_modified_by_seb46/PNG/Round without details/"
var evol1 = "res://kenney_animalpackredux_modified_by_seb46/PNG/Round without details (outline)/"
var evol2 = "res://kenney_animalpackredux_modified_by_seb46/PNG/Square without details (outline)/"
var son = "res://sci-fi-sounds_modified_by_seb_46/Audio/"

var pv = 3
var diametre_max


func _ready():
	add_to_group("tetes")
	$KennySprite.texture = load(evol0 + self_color + str(number_color) + ".png")
	scale.x = 0.5 + number_color / 10
	scale.y = 0.5 + number_color / 10
	diametre_max = 1 - 0.1 * number_color
	
	$Son.stream = load(son + "new_head.wav")
	$Son.volume_db = 6.0
	$Son.play()
	yield(get_tree().create_timer(0.5), "timeout")
	$Son.volume_db = 0.0
	
	


func _on_Head_body_entered(body):
	if body.type == "feuille":
		manger(body)
	elif body.type == "techno":
		degats(body)
		
		
func manger(body):
	if scale.x < diametre_max and body.color == self_color:
		$Son.stream = load(son + body.color + ".wav")
		$Son.play()
		scale.x += 0.1
		scale.y += 0.1
		if scale.x >= diametre_max:
			$KennySprite.texture = load(evol1 + self_color + str(number_color) + ".png")
			$KennySprite.modulate.a = 1

		
			
	if body.color != self_color and body.color != "yellow":
		if next_colors[body.color] == 0:
			$Son.stream = load(son + body.color + ".wav")
			$Son.play()
			next_colors[body.color] += 1
		elif next_colors[body.color] == 1:
			$Son.stream = load(son + body.color + ".wav")
			$Son.play()
			if number_color == 4:
				victoire_croissance(body)
				return			
			next_colors[body.color] += 1
			var new_head = load("res://Head.tscn").instance()
			new_head.self_color = body.color
			new_head.number_color = number_color + 1
			var angle = randf()
			new_head.position.x = cos(angle * 2 * PI) * 64
			new_head.position.y = sin(angle * 2 * PI) * 64
			add_child(new_head)
			
			if next_colors["blue"] == 1 and next_colors["brown"] == 1 and next_colors["green"] == 1 and next_colors["grey"] == 1 and next_colors["pink"] == 1:
				$CollisionShape2D.disabled = true
	
	body.liberer()
	
	
func degats(body):
	if scale.x < diametre_max:
		body.liberer()
		pv -= 1
		$Son.stream = load(son + "blessure.wav")
		$Son.play()
		hide()
		yield(get_tree().create_timer(0.1),"timeout")
		show()
		yield(get_tree().create_timer(0.1),"timeout")
		hide()
		yield(get_tree().create_timer(0.1),"timeout")
		show()
		$KennySprite.modulate.a -= 0.2
		if pv <= 0:
			$Son.stream = load(son + "brick.wav")
			$Son.play()
			$KennySprite.texture = load(evol2 + self_color + str(number_color) + ".png")
			$KennySprite.modulate.a = 0.5
			$CollisionShape2D.disabled = true


func victoire_croissance(body):
	$Son.stream = load(son + "victory.wav")
	$Son.play()
	body.victoire_croissance()
	
	
func explosion():
	var x = randi() % 100 - 50
	var y = randi() % 100 - 50
	for _i in range(40):
		position.x += x
		position.y += y
		yield(get_tree().create_timer(0.05),"timeout")
