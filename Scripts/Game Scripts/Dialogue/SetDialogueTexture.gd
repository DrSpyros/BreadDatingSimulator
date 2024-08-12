extends Sprite2D

func _on_dialogue_set_texture(CharTexture):
	var LoadedCharTexture = load(CharTexture)
	print(CharTexture)
	texture = LoadedCharTexture
