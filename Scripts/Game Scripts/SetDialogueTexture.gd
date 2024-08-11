extends Sprite2D

func _on_dialogue_box_set_texture(CharTexture):
	var LoadedCharTexture = load(CharTexture)
	print(CharTexture)
	texture = LoadedCharTexture
