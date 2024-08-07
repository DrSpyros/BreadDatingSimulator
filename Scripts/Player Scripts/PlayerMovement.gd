extends CharacterBody2D

@export var Speed = 150
@export var SprintingSpeed = 300
@export var MaxStamina = 500
@export var CanMove = true
var StaminaRegening = false
var Stamina = MaxStamina
var CanAttack = true
var PlayerFacing = "Down"
signal PlayerAttack

func get_input():
	if Input.is_action_just_pressed("Attack"):
		if CanAttack == true:
			emit_signal("PlayerAttack")
	var input_direction = Vector2.ZERO
	var FinalSpeed = Speed
	if CanMove == true:
		input_direction = Input.get_vector("Left", "Right", "Up", "Down")
		
		if Stamina <= MaxStamina:
			if StaminaRegening == true:
				Stamina += 5
		else:
			StaminaRegening = false
			Stamina = MaxStamina
		
		
		
		if Input.is_action_pressed("Sprint"):
			if Stamina >= 0:
				if StaminaRegening == false:
					FinalSpeed = SprintingSpeed
					Stamina -= 10
			else:
				StaminaRegening = true
		else:
			if Stamina <= MaxStamina:
				if StaminaRegening == false:
					Stamina += 5
			else:
				StaminaRegening = false
				Stamina = MaxStamina
			
	if CanMove == false:
		FinalSpeed = 0
	velocity = input_direction * FinalSpeed
	
	move_and_slide()
	PlayerFacing = input_direction
	
	
func _physics_process(delta):
	$"Stamina Bar".value = Stamina
	$"Stamina Bar".max_value = MaxStamina
	if StaminaRegening == true:
		$"Stamina Bar".modulate = Color(1, 0, 0)
	else:
		$"Stamina Bar".modulate = Color(1, 1, 1)
	
	get_input()


func _on_inventory_player_can_move(TF):
	CanMove = TF
	$"Player Sprite".visible = TF
