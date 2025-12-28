extends Node2D

#========================================
#	Note: input-keys are just fo testing
#========================================

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
var stage_sprites =  {
	0: "stage_1",
	1: "stage_2",
	2: "stage_3",
	3: "stage_4"
}

var grow_time := 20.0
var timer := 0.0

var plant_stage := 0
const max_stage = 3
var plant_stage_increase_time := grow_time/4

var watered := false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if plant_stage <  max_stage:
		growth(delta)
		watering()
		animated_sprite.play(stage_sprites[plant_stage])
	else:
		harvest()

func growth(delta) :
	timer += delta
	if timer >= plant_stage_increase_time:
		plant_stage += 1
		plant_stage_increase_time += plant_stage_increase_time
		print("I grew!")
		print("I am now at stage " + str(plant_stage))

# watering should halve grow_time
func watering():
	if Input.is_action_just_pressed("watering"):
		if not watered:
			grow_time /= 2
			plant_stage_increase_time /= 2
			watered = true
		print("watered")

func harvest():
	if Input.is_action_just_pressed("harvest"):
		print("harvested")
		queue_free()
