extends Node

var current_velocity_value = Vector2(0,0)
var p_mass_value = 100
var size_value
var prediction_node_value
var selected_celestial_body : CelestialBody
var celestial_bodies = []

var mass_spinbox
var pos_spinbox = []
var initial_vel_spinbox = []
var celbody_name_spinbox: Label

var big_g_spinbox
var distance_mul_spinbox 

func _ready():
	celbody_name_spinbox = get_node("/root/Main/CanvasLayer/Panel/Control/GridContainer/CelBodyName")

	mass_spinbox = get_node("/root/Main/CanvasLayer/Panel/Control/GridContainer/HBoxContainer/Mass")

	pos_spinbox.append( get_node("/root/Main/CanvasLayer/Panel/Control/GridContainer/HBoxContainer/VBoxContainer2/X"))
	pos_spinbox.append( get_node("/root/Main/CanvasLayer/Panel/Control/GridContainer/HBoxContainer/VBoxContainer2/Y"))

	initial_vel_spinbox.append(get_node("/root/Main/CanvasLayer/Panel/Control/GridContainer/HBoxContainer/VBoxContainer/X"))
	initial_vel_spinbox.append(get_node("/root/Main/CanvasLayer/Panel/Control/GridContainer/HBoxContainer/VBoxContainer/Y"))

	big_g_spinbox = get_node("/root/Main/CanvasLayer/Panel/Control/GridContainer/HBoxContainer/VBoxContainer3/BigG")
	distance_mul_spinbox = get_node("/root/Main/CanvasLayer/Panel/Control/GridContainer/HBoxContainer/VBoxContainer3/DistanceMultiplier")
	print(distance_mul_spinbox)

func set_planet_info(cel_body: CelestialBody, cel_bodies):
	selected_celestial_body = cel_body
	celestial_bodies = cel_bodies

	# print(selected_celestial_body.name, " mass ", selected_celestial_body.p_mass)
	
	pos_spinbox[0].set_value(selected_celestial_body.global_position.x)
	pos_spinbox[1].set_value(selected_celestial_body.global_position.y)

	initial_vel_spinbox[0].set_value(selected_celestial_body.current_velocity.x)
	initial_vel_spinbox[1].set_value(selected_celestial_body.current_velocity.y)

	mass_spinbox.set_value(selected_celestial_body.p_mass)

	celbody_name_spinbox.text = "Name: " + selected_celestial_body.name
	
	big_g_spinbox.set_value(UniversalValues.big_g)
	distance_mul_spinbox.set_value(UniversalValues.distance_multiplier)
	# print(celbody_name_spinbox)

	
func _update_predict():
	var predict_node = get_node("/root/Main/Prediction")
	predict_node.draw_orbits(celestial_bodies, predict_node.position)
	
func update_values():
	pos_spinbox[0].set_value(selected_celestial_body.global_position.x)
	pos_spinbox[1].set_value(selected_celestial_body.global_position.y)

	initial_vel_spinbox[0].set_value(selected_celestial_body.current_velocity.x)
	initial_vel_spinbox[1].set_value(selected_celestial_body.current_velocity.y)

	mass_spinbox.set_value(selected_celestial_body.p_mass)
	_update_predict()
	pass

func _on_X_value_changed(value):
	if selected_celestial_body:
		selected_celestial_body.global_position.x = value
		# print(value)
		_update_predict()

func _on_Y_value_changed(value):
	if selected_celestial_body:
		selected_celestial_body.global_position.y = value
		# print(value)
		_update_predict()

func _on_X_vel_value_changed(value: float ):
	if selected_celestial_body:
		selected_celestial_body.current_velocity.x = value
		# print(value)
		_update_predict()

func _on_Y_vel_value_changed(value: float ):
	if selected_celestial_body:
		selected_celestial_body.current_velocity.y = value
		# print(value)
		_update_predict()

func _on_Mass_value_changed(value: float):
	if selected_celestial_body:
		selected_celestial_body.p_mass = value
		# print(value)
		_update_predict()

func _on_BigG_value_changed(value: float):
	UniversalValues.big_g = value
	_update_predict()

func _on_DistanceMultiplier_value_changed(value):
	UniversalValues.distance_multiplier = value
	_update_predict()
	
