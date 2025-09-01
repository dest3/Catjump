extends CharacterBody2D

class_name Player

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const DASH_SPEED = 600.0
const DASH_DURATION = 0.5

var is_dashing := false
var dash_timer := 0.0
var can_double_jump := true
var on_floor
var direction

@onready var sprite_player: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	play_anim("Idle")

func _physics_process(delta: float) -> void:
	player_movement()
	add_gravity(delta)
	flip_animation()
	duble_jump()
	update_animation(on_floor, direction)
	dash_Control(delta)

#ayudante para reproducir animaciones
func play_anim(name : String) -> void:
	if sprite_player.animation != name:
		sprite_player.play(name)

#reproduce animaciones 
func update_animation(on_floor : bool, direction: float) -> void:
	if is_dashing:
		play_anim("Run")
	elif not on_floor:
		play_anim("Jump")
	elif abs(velocity.x) > 10:
		play_anim("Walk")
	else:
		play_anim("Idle")

#maneja el doble salto
func duble_jump():
	# Manejo de Doble salto
	if Input.is_action_just_pressed("ui_accept"):
		if on_floor:
			velocity.y = JUMP_VELOCITY
			can_double_jump = true
			if is_dashing:
				play_anim("Jump_Dash")
			else:
				play_anim("Jump")
		elif can_double_jump:
			velocity.y = JUMP_VELOCITY
			can_double_jump = false
			play_anim("Jump")

#movimiento del personaje
func player_movement():
	direction = Input.get_axis("move_left", "move_right")
	move_and_slide()

#agrega gravedad
func add_gravity(delta):
	#Agrega Gravedad
	on_floor = is_on_floor()
	if not is_on_floor() and not is_dashing:
		velocity += get_gravity() * delta

#controla el dash
func dash_Control(delta):
	if Input.is_action_just_pressed("dash") and not is_dashing:
		start_dash(direction)
	
	if is_dashing:
		dash_timer -=  delta
		if dash_timer <= 0:
			is_dashing = false
	
	if not is_dashing:
		if direction != 0:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

#aplica el dash en la direccion correcta y controla el tiempo
func start_dash(direction : float) -> void:
	if direction == 0:
		return
		
	is_dashing = true
	dash_timer = DASH_DURATION
	velocity.x = direction * DASH_SPEED
	velocity.y = 0
	play_anim("Run")

#voltea la animacion dependiendo de la direccion 
func flip_animation():
	if direction != 0 and !is_dashing:
		sprite_player.flip_h = direction > 0
