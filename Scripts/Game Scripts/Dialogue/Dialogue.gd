extends ColorRect

signal SetText(DialogueText)
signal SetTexture(CharTexture)
signal SetName(CharName)
signal PlayAnim(Anim)
var AnimationPlayed = false

func _ready():
	$Dialoguebox.text = "a"
	visible = true
	await get_tree().create_timer(2).timeout
	SendDialogue("yes hello it;s me hot whoman", "MarkMayhem", "Talking_Neutral")

func _process(delta):
	if visible == true:
		if AnimationPlayed == false:
			AnimationPlayed = true
			emit_signal("PlayAnim", "StartDialogue")
	else:
		AnimationPlayed = false

func SendDialogue(DialogueText, Name, State):
	visible = true
	var CharTexture = "res://Images/CharacterSprites/" + str(Name) + "/" + str(State) + ".png"
	emit_signal("SetTexture", CharTexture)
	emit_signal("SetName", Name)
	emit_signal("SetText", "")
	await get_tree().create_timer(0.5).timeout
	for Index in DialogueText.length():
		var CutText = DialogueText.erase(Index, DialogueText.length())
		emit_signal("SetText", CutText)
		await get_tree().create_timer(0.05).timeout
		
	emit_signal("SetText", DialogueText)

func EndDialogue():
	var AnimationPlayed = false
	visible = false
