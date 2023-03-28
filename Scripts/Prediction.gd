extends Line2D
var PLANET_SCHEME = load("res://Scenes/Point.tscn")

class_name Prediction

var num_steps : int = 3000
var time_step : float = 0.01
var use_physics_time_step : bool
var reletaive_to_body : bool = false
var central_body : CelestialBody
		
class VirtualBody:
	var pos
	var vel
	var p_mass
	func _init(body: CelestialBody): 
		pos = body.global_position
		vel = body.current_velocity
		p_mass = body.p_mass

func draw_orbits(other_bodies,predic_pos):
	var virtual_bodies = []
	var draw_points = []
	var reference_frame_index : int
	var reference_initial_pos = Vector2.ZERO

	for i in len(other_bodies):
		virtual_bodies.append(VirtualBody.new(other_bodies[i]))

		if (other_bodies[i] == central_body && reletaive_to_body):
			reference_frame_index = i
			reference_initial_pos = virtual_bodies[i].pos

		draw_points.append([])


	for step in num_steps:
		var ref_body_pos = Vector2.ZERO

		if reletaive_to_body:
			ref_body_pos = virtual_bodies[reference_frame_index].pos

		for i in len(virtual_bodies):
			virtual_bodies[i].vel += calc_accel(i, virtual_bodies) * time_step
		
		# draw_points.append([Vector2.ZERO,Vector2.ZERO,Vector2.ZERO])
		for i in len(virtual_bodies):
			
			var new_pos : Vector2 = virtual_bodies[i].pos + virtual_bodies[i].vel * time_step
			virtual_bodies[i].pos = new_pos

			if reletaive_to_body:
				var reference_frame_offset = ref_body_pos - reference_initial_pos
				new_pos -= reference_frame_offset

			if reletaive_to_body && i == reference_frame_index:
				new_pos = reference_initial_pos

			draw_points[i].append(new_pos)
			
	if !GameState.game_paused:
		for i in range(len(virtual_bodies)):
			var line = other_bodies[i].get_child(3)
			# print(line.name)
			for j in len(draw_points[i]):
				# if constrain % 10 == 0:

					# var planet = PLANET_SCHEME.instance()
					
					# add_child(planet)
					# planet.global_position = draw_points[i][j] 
					line.add_point(draw_points[i][j] + (predic_pos - other_bodies[i].position))
					# print(draw_points[i][j])
					while line.get_point_count()>num_steps:
						line.remove_point(0)
				# constrain+=1

func remove_prediction(other_bodies):
	for i in len(other_bodies):
		var line: Line2D = other_bodies[i].get_child(3)
		while line.get_point_count() > 0:
			line.remove_point(0)

func calc_accel(i, virt_bodies) -> Vector2:
	var acceleration = Vector2.ZERO
	for j in len(virt_bodies):
		if(j == i):
			continue
		# var sqrt_dis = clamp(sqrt(virt_bodies[j].pos.distance_to(virt_bodies[i].pos)) * 1000, 0.000001, INF)
		var sqrt_dis = sqrt(virt_bodies[j].pos.distance_to(virt_bodies[i].pos) * UniversalValues.distance_multiplier)
		var force_dir = (virt_bodies[j].pos - virt_bodies[i].pos).normalized()
		acceleration += force_dir * UniversalValues.big_g * virt_bodies[j].p_mass  / sqrt_dis
		
		# print(" virtual dis ", sqrt_dis, " acceleration ", acceleration, " frcdir ", force_dir)

	return acceleration


func _init():
	pass
