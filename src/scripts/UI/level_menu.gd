extends Control

#conectar todos los nivelers aca equisde

func _on_nivel_1_pressed() -> void:
	LevelManager.load_level(1)


func _on_nivel_2_pressed() -> void:
	LevelManager.load_level(2)


func _on_nivel_3_pressed() -> void:
	pass # Replace with function body.


func _on_salir_bt_pressed() -> void:
	get_tree().change_scene_to_file("res://src/scenes/UI/main_menu.tscn")
