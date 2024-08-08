extends Label

@onready var TextBox = self
@onready var Name = $DialogueName

func _ready():
	await get_tree().create_timer(1).timeout
	SendDialogue("peepeepoopoo")

func SendDialogue(DialogueText):
	for Index in DialogueText.length():
		var CutText = DialogueText.erase(Index, DialogueText.length())
		text = CutText
		await get_tree().create_timer(0.05).timeout
		
