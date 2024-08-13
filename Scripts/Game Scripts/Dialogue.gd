extends ColorRect
class_name Dialogue

@onready var DialogueBox : Label = $DialogueBox
@onready var DialogueName : Label = $DialogueBox/DialogueName
@onready var DialogueTexture = $DialogueBox/Sprite2D
@onready var DialogueAnimation = $AnimationPlayer
var AnimationPlayed = false

func _ready():
	AL.DialogueScene = self
	visible = false

func _process(delta):
	if visible == true:
		if AnimationPlayed == false:
			AnimationPlayed = true
			DialogueAnimation.play("StartDialogue")
	else:
		AnimationPlayed = false
		
func SendDialogue(DialogueDic: Dictionary, Name):
	visible = true
	AL.PlayerScene.CanMove = false
	var Dialogues: Array = DialogueDic.keys()
	var LastState: String = ""
	for CurrentDialogueIndex: int in DialogueDic.size():
		
		var DialogueText: String = Dialogues[CurrentDialogueIndex]
		var State: String = DialogueDic[DialogueText]
		
		if AnimationPlayed == true:
			if State != LastState:
				await get_tree().create_timer(0.1).timeout
				DialogueAnimation.play("DialogueTransition")
				await get_tree().create_timer(0.04).timeout
		DialogueTexture.texture = load("res://Images/CharacterSprites/" + str(Name) + "/" + str(State) + ".png")
		DialogueName.text = Name
		DialogueBox.text = ""
		await get_tree().create_timer(0.5).timeout
		for Index in DialogueText.length():
			var CutText = DialogueText.erase(Index, DialogueText.length())
			DialogueBox.text = CutText
			var CurrentLetter = DialogueText.erase(Index + 1, DialogueText.length() + 1)
			CurrentLetter = CurrentLetter.erase(0, Index)
			if CurrentLetter == " ":
				DialogueTexture.texture = load("res://Images/CharacterSprites/" + str(Name) + "/" + str(State) + ".png")
			else:
				DialogueTexture.texture = load("res://Images/CharacterSprites/" + str(Name) + "/" + "Talking_" + str(State) + ".png")
			if CurrentLetter == ".":
				DialogueTexture.texture = load("res://Images/CharacterSprites/" + str(Name) + "/" + str(State) + ".png")
				await get_tree().create_timer(0.2).timeout
			await get_tree().create_timer(0.05).timeout
			
		DialogueBox.text = DialogueText
		DialogueTexture.texture = load("res://Images/CharacterSprites/" + str(Name) + "/" + str(State) + ".png")
		await get_tree().create_timer(2.5).timeout
		LastState = State
	
	EndDialogue()
	
func EndDialogue():
	var AnimationPlayed = false
	DialogueAnimation.play_backwards("StartDialogue")
	await get_tree().create_timer(0.3).timeout
	visible = false
	AL.PlayerScene.CanMove = true
