extends Label

@onready var TextBox = self
@onready var NameBox = $DialogueName
@onready var SpriteBox = $Sprite2D
signal SetTexture(CharTexture)

func _ready():
	await get_tree().create_timer(1).timeout
	SendDialogue("very cool dialogue", "DrSpyros", "Neutral")

func SendDialogue(DialogueText, Name, State):
	NameBox = Name
	var CharTexture = "res://Images/CharacterSprites/" + str(Name) + "/" + str(State) + ".png"
	emit_signal("SetTexture", CharTexture)
	for Index in DialogueText.length():
		var CutText = DialogueText.erase(Index, DialogueText.length())
		self.text = CutText
		await get_tree().create_timer(0.05).timeout
		
	self.text = DialogueText
