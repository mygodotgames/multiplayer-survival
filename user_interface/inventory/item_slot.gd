extends PanelContainer

@onready var icon_texture: TextureRect = %TextureRect
 
func display(item: Item):
	if item and item.icon:
		print("Displaying item: ", item.name) 
		icon_texture.texture = item.icon
		show()
	else:
		set_empty()

func set_empty():
	icon_texture.texture = null
 
