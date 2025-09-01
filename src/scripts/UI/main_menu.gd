extends Control

class_name MainMenu
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer


func _on_play_bt_pressed() -> void:
	LevelManager.load_level(2)
	deactivate()
	audio_stream_player.stop()


func _on_niveles_bt_pressed() -> void:
	pass 


func _on_salir_bt_pressed() -> void:
	get_tree().quit()

func deactivate() -> void:
	hide()
	set_process(false)
	set_process_unhandled_input(false)
	set_process_input(false)
	set_physics_process(false)
	
func activate() -> void:
	show()
	set_process(true)
	set_process_unhandled_input(true)
	set_process_input(true)
	set_physics_process(true)
