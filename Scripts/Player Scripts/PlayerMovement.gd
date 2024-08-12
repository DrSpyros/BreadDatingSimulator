extends CharacterBody2D

@export var Speed = 150
@export var CanMove = true


func get_input():
	if Input.is_action_just_pressed("Interact"):
		AL.DialogueScene.SendDialogue("Hello this is some fun text. whooho", "DrSpyros", "Neutral")
	var input_direction = Vector2.ZERO
	var FinalSpeed = Speed
	if CanMove == true:
		input_direction = Input.get_vector("Left", "Right", "Up", "Down")
			
	if CanMove == false:
		FinalSpeed = 0
	velocity = input_direction * FinalSpeed
	
	move_and_slide()
	
func _physics_process(delta):
	get_input()
