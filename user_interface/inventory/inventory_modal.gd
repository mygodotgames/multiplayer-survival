# InventoryModal.gd
class_name InventoryModal
extends Container

@export var slot_scene: PackedScene
@onready var grid_container: GridContainer = $Inventory/VBoxContainer/GridContainer
 

func _ready():
 
	var player_inventory = InventoryManager.get_player_inventory()
	 
	if player_inventory == null:
		print("Envanter bulunamadı!")
	else:
		print("Envanter başarıyla alındı:", player_inventory)
		
		# SGINALE BAĞLA BABA
		if player_inventory.connect("inventory_updated", Callable(self, "_on_inventory_updated")) == OK:
			print("Sinyal başarıyla bağlandı!")
		else:
			print("Sinyal bağlanamadı!")
		
		refresh_inventory()
		 
 
		
func refresh_inventory():
	 
	var player_inventory = InventoryManager.get_player_inventory()
 
	var items = player_inventory.get_items()

	# Öğeleri yazdırarak kontrol edelim
	print("items öğeler:", items)

	# Grid'i temizliyoruz
	for child in grid_container.get_children():
		child.queue_free()  # Çocukları silmek için queue_free kullanıyoruz

	# Envanterdeki her öğe için slot oluşturuyoruz
	for item in items:
		var slot = slot_scene.instantiate()  # Yeni bir slot oluşturuluyor
		grid_container.add_child(slot)  # GridContainer'a slot ekleniyor

		# Eğer item null ise, slotu boş olarak ayarlıyoruz
		if item:
			slot.display(item)  # Öğeyi slotta göster
		else:
			slot.set_empty()  # Eğer öğe yoksa, boş bir slot göster


func _on_inventory_updated():
	print("Envanter güncellendi!")
	var player_inventory = InventoryManager.get_player_inventory()
	
	# Grid'i temizleyip yenisi eklenmeden önce güvenlik kontrolü
	if player_inventory && grid_container:
		refresh_inventory()  # Envanteri yenileyin
	else:
		print("Envanter veya GridContainer bulunamadı!")
 
