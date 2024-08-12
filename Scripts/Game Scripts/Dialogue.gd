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
	else:
		AnimationPlayed = false

func SendDialogue(DialogueText, Name, State):
	visible = true
	
	DialogueTexture.texture = load("res://Images/CharacterSprites/" + str(Name) + "/" + str(State) + ".png")
	DialogueAnimation.play("StartDialogue")
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

func EndDialogue():
	var AnimationPlayed = false
	visible = false
