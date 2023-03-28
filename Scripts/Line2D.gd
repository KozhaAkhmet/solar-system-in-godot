extends Line2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var length = 50
var point = Vector2()
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position = Vector2(0,0)
	global_rotation = 0

	point = get_parent().global_position

	add_point(point)
	while get_point_count()>length:
		remove_point(0)


    # public static Vector3 CalculateAcceleration (Vector3 point, CelestialBody ignoreBody = null) {
    #     Vector3 acceleration = Vector3.zero;
    #     foreach (var body in Instance.bodies) {
    #         if (body != ignoreBody) {
    #             float sqrDst = (body.Position - point).sqrMagnitude;
    #             Vector3 forceDir = (body.Position - point).normalized;
    #             acceleration += forceDir * Universe.gravitationalConstant * body.mass / sqrDst;
    #         }
    #     }

    #     return acceleration;
    # }