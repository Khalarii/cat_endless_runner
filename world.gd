extends Node2D

@export var bullet_scene: PackedScene
@onready var player_scene = $Player

var recently_shot_bullet = false

func run_after_timer(wait_time: float, callback_function: Callable):
	var timer := Timer.new()
	
	timer.wait_time = wait_time
	timer.one_shot = true
	timer.connect("timeout", callback_function)
	
	add_child(timer)
	
	timer.start()

func unset_recently_shot_bullet():
	recently_shot_bullet = false
	
func _physics_process(delta):
	if Input.is_action_pressed("shoot") && !recently_shot_bullet:
		recently_shot_bullet = true
		
		var bullet = bullet_scene.instantiate()
		
		bullet.position = player_scene.position + Vector2(20, 0)
		bullet.set_linear_velocity(Vector2(200, 0))
		
		add_child(bullet)
		
		run_after_timer(1.0, unset_recently_shot_bullet)
