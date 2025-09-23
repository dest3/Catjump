extends Area2D

var fall 
@export var fall_speed: int = 450

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if fall:
		position.y += fall_speed * delta


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		fall = true
	
