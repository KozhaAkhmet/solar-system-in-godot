extends RigidBody2D

class_name CelestialBody
 
export var current_velocity = Vector2(0,0)
var current_body :CelestialBody
var force
export var p_mass: float = 100
var size: float

var prediction_node
var controller_node
var ui_node 

func _ready():
	controller_node = get_node("/root/Main/Controller")
	prediction_node = get_node("/root/Main/Prediction")
	ui_node = get_node("/root/Main/UI")

func update_velocity(other_body: RigidBody2D, delta):
		# var sqrt_dis = clamp(sqrt(other_body.global_position.distance_to(global_position)),0.1,INF)
		var sqrt_dis = sqrt(other_body.global_position.distance_to(global_position) * UniversalValues.distance_multiplier ) 

		var force_dir = (other_body.global_position - global_position).normalized()
		force = force_dir * UniversalValues.big_g * p_mass * other_body.p_mass / sqrt_dis
		var acceleration = force / p_mass
		current_velocity = current_velocity + acceleration * delta
	# print(" Planet dis ", sqrt_dis, " acceleration ", acceleration, " frcdir ", force_dir)
	# print("name ", get_parent().name," sqrt dis ",sqrt_dis, " force ", force, " force dir ", force_dir, " other body ", other_body.position, " velocity ", current_velocity)
	

func update_position(delta):
		global_position = global_position + current_velocity * delta

func show_velocity():
	var line: Line2D = get_child(2)
	var line_positions : PoolVector2Array = [Vector2.ZERO,Vector2(current_velocity / 2)]
	line.points = line_positions

# func show_force(child_size):
#     var line: Line2D = get_child(4)
#     for i in range(child_size):

#     var line_positions : PoolVector2Array = [Vector2.ZERO,Vector2(force / 2)]
#     line.points = line_positions

func set_planet_mass(value) -> CelestialBody :
	p_mass = (value)
	return self

func set_size(value) -> CelestialBody:
	size = value
	return self

func set_initial_velocity(value) -> CelestialBody:
	current_velocity = value
	return self

var pos_button_down = false
var pos_button_up = false

func _on_Button_button_up():
	ui_node.update_values()
	pos_button_up = true

func _on_Button_button_down():
	pos_button_down = true
	ui_node.set_planet_info(self, controller_node.get_children())
	current_body = self

func _process(delta):
	if !GameState.game_paused:
		if pos_button_down:
			if !controller_node.paused:
				global_position = get_global_mouse_position()
				prediction_node.draw_orbits(controller_node.get_children(), prediction_node.position)
			if pos_button_up: 
				pos_button_down = false
				pos_button_up = false

func _init():
	
	print("Constructed!")


