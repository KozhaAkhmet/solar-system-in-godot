extends Node2D
const PLANET_SCHEME = preload("res://Scenes/Planet.tscn")
const SUN_SCHEME = preload("res://Scenes/Sun.tscn")


var all_childs
var paused: bool

func _ready():
	all_childs = get_children()
	set_physics_process(false)

func _physics_process(delta):
	for current in all_childs:
			for other_body in all_childs:
				if(other_body != current && (other_body != Node2D && current != Node2D)):
					other_body.update_velocity(current,delta)
		
	for body in all_childs:
		body.update_position(delta)
		body.show_velocity()
	
func _on_CheckButton_toggled(button_pressed: bool):
	set_physics_process(button_pressed)
	GameState.game_paused = button_pressed
	var prediction = get_node("/root/Main/Prediction")
	if button_pressed:
		prediction.remove_prediction(all_childs)
	else:
		prediction.draw_orbits(all_childs,prediction.position)

