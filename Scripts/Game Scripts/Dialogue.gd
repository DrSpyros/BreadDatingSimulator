extends ColorRect

signal SetText(DialogueText)
signal SetTexture(CharTexture)
signal SetName(CharName)

func _ready():
	await get_tree().create_timer(1).timeout
	SendDialogue("very cool dialogue", "DrSpyros", "Neutral")

func SendDialogue(DialogueText, Name, State):
	var CharTexture = "res://Images/CharacterSprites/" + str(Name) + "/" + str(State) + ".png"
	emit_signal("SetTexture", CharTexture)
	emit_signal("SetName", Name)
	for Index in DialogueText.length():
		var CutText = DialogueText.erase(Index, DialogueText.length())
		emit_signal("SetText", CutText)
		await get_tree().create_timer(0.05).timeout
		
	emit_signal("SetText", DialogueText)
