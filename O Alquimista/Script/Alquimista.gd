extends KinematicBody2D

const UP = Vector2(0 ,-1)
const GRAVITY = 20
const SPEED = 500
const JUMP = -600
var motion = Vector2()
var vida = 5
var poder = preload("res://Personagem/BolaDeFogo.tscn")

func _physics_process(delta):

# Gravidade
	motion.y += GRAVITY

# Andar
	if Input.is_action_pressed("ui_right"):
		motion.x = SPEED
		$Sprite.play("Run")
		$Sprite.flip_h = false
	elif Input.is_action_pressed("ui_left"):
		motion.x = -SPEED
		$Sprite.play("Run")
		$Sprite.flip_h = true
	else:
		motion.x = 0
		$Sprite.play("Idle")
	
# Pulo
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			motion.y = JUMP
	else :
		$Sprite.play("Jump")


# Morre ao cair da plataforma
	if ($".".position.y >= 1200):
		get_tree().change_scene("res://Menu.tscn")
		
	motion = move_and_slide(motion, UP)

# Sprite de posição de ataque
	if Input.is_action_pressed("ui_select"):
		$Sprite.play("Poder")

# Bola de fogo
	if Input.is_action_just_pressed("ui_select"):
		# instancia um nó de fora
		var _poder = poder.instance()
		# pega a mesma posição do objeto
		_poder.position = $".".position
		
		#verifica pra qual lado o personagem está virado
		# e muda o sprite da bola de fogo
		if $Sprite.flip_h == false:
			get_node("../").add_child(_poder)
		else:
			_poder.velocidade = -10
			get_node("../").add_child(_poder)
		

# Pula ao tocar na cabeça do inimigo
# Calsa dano no inimigo
func _on_Pes_body_entered(body):
	motion.y = JUMP
	body.dano()
# Sofre dano
func _on_Dano_body_entered(body):
	vida -= 1
	if (vida <= 0):
		get_tree().change_scene("res://Menu.tscn")
		

