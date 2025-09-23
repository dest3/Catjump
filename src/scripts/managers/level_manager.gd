extends Node
# Este script se encarga de manejar la carga y descarga de niveles en el juego.

# Lista de todos los niveles disponibles (definidos con recursos LevelData).
var levels : Array[LevelData] 

# Referencia al nodo principal (la escena donde se van a añadir los niveles cargados).
var main_scene : Node2D = null

# Referencia al nivel actualmente cargado (instancia de la escena del nivel).
var loaded_level : Level = null


# ----------------------------------------
# DESCARGAR NIVEL ACTUAL
# ----------------------------------------
func unload_level() -> void:
	# Verifica si hay un nivel cargado y si la instancia sigue siendo válida.
	if is_instance_valid(loaded_level):
		# Elimina el nivel actual de la escena.
		loaded_level.queue_free()
	
	# Limpia la referencia para indicar que ya no hay un nivel cargado.
	loaded_level = null


# ----------------------------------------
# CARGAR UN NUEVO NIVEL
# ----------------------------------------
func load_level(level_id : int) -> void:
	# Primero descarga cualquier nivel que esté cargado.
	unload_level()

	# Obtiene la información (LevelData) del nivel según el ID.
	var level_data = get_level_by_id(level_id)
	
	# Si no existe un LevelData con ese ID, se cancela la carga.
	if not level_data:
		return
		
	# Construye la ruta al archivo de la escena del nivel (.tscn).
	# Ejemplo: "res://src/scenes/nivel1.tscn"
	var level_path = "res://src/scenes/%s.tscn" % level_data.level_path
	
	# Intenta cargar el recurso de la escena.
	var level_res := load(level_path)
	
	# Si el recurso se cargó correctamente:
	if level_res:
		# Instancia la escena del nivel.
		loaded_level = level_res.instantiate()
		
		# Agrega el nivel como hijo de la escena principal.
		main_scene.add_child(loaded_level)
	else:
		# Si no se encontró el recurso, imprime un mensaje de error.
		print("Nivel inexistente")


# ----------------------------------------
# BUSCAR UN NIVEL POR ID
# ----------------------------------------
func get_level_by_id(level_id : int) -> LevelData:
	# Variable temporal para devolver el resultado (null si no lo encuentra).
	var level_returning : LevelData = null
		
	# Recorre todos los niveles registrados.
	for level: LevelData in levels:
		# Si encuentra un nivel con el mismo ID, lo guarda.
		if level.level_id == level_id:
			level_returning = level
				
	# Devuelve el LevelData encontrado (o null si no existe).
	return level_returning
