extends CharacterBody2D
class_name Player

@export var Speed = 300
@onready var Sprite: AnimatedSprite2D = $AnimatedSprite2D
var CanMove = true
var LastMovement: String = "Down"

func _ready():
	AL.PlayerScene = self

func get_input():
	if CanMove == true:
		if Input.is_action_pressed("Right"):
			Sprite.flip_h = false
			Sprite.play("Walking_Side")
			LastMovement = "Side"
		elif Input.is_action_pressed("Left"):
			Sprite.flip_h = true
			Sprite.play("Walking_Side")
			LastMovement = "Side"
		elif Input.is_action_pressed("Down"):
			Sprite.flip_h = false
			Sprite.play("Walking_Down")
			LastMovement = "Down"
		elif Input.is_action_pressed("Up"):
			Sprite.flip_h = false
			Sprite.play("Walking_Up")
			LastMovement = "Up"
		else:
			Sprite.play("Idle_" + LastMovement)
	else:
		Sprite.play("Idle_" + LastMovement)
	
	
	
	if Input.is_action_just_pressed("Interact"):
		var Dialogues = {
			"Dialogue yay": "Neutral",
			"This is the second part of my Dialogue": "Neutral",
			"This is the third dialogue omg!!": "Angry",
			"Andddd, the alst one. pog": "Neutral"
		}
		AL.DialogueScene.SendDialogue(Dialogues, "DrSpyros")
		
	var input_direction: Vector2 = Vector2.ZERO
	var FinalSpeed = Speed
	if CanMove == true:
		input_direction = Input.get_vector("Left", "Right", "Up", "Down")
			
	if CanMove == false:
		FinalSpeed = 0
	velocity = input_direction * FinalSpeed
	
	move_and_slide()
	
func _physics_process(delta):
	get_input()
