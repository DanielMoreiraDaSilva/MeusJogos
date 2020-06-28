extends KinematicBody2D

const UP = Vector2(0 ,-1)
const GRAVITY = 20
const SPEED = 500
const JUMP = -600
var motion = Vector2()
var poder = preload("res://Personagem/BolaDeFogo.tscn")
var barraVida

func _ready():
	barraVida = get_tree().get_nodes_in_group("HP")[0]

func _physics_process(delta):

	atualizar_barra_de_vida()

# Gravidade
	motion.y += GRAVITY
	
	_movimentacao()
	
	_morte_ao_cair()
	
	motion = move_and_slide(motion, UP)



# Bola de fogo
	if Input.is_action_just_pressed("ui_select"):
		_Disparar_poder()
	elif Input.is_action_pressed("ui_select"):
		$Sprite.play("Poder")

func _Disparar_poder():
	
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

func atualizar_barra_de_vida():
	if (VariaveisGlobais.vida_atual_alquimista != 0):
		barraVida.value = VariaveisGlobais.vida_atual_alquimista * barraVida.max_value / VariaveisGlobais.vida_atual_alquimista

func _movimentacao():
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
		
	# Pular
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			motion.y = JUMP
	else :
		$Sprite.play("Jump")
		

func _morte_ao_cair():
	# Morre ao cair da plataforma
	if ($".".position.y >= 1200):
		VariaveisGlobais.vida_atual_alquimista = VariaveisGlobais.vida_max_alquimista
		get_tree().change_scene("res://Menu.tscn")


# Pula ao tocar na cabeça do inimigo
# Calsa dano no inimigo
func _on_Pes_body_entered(body):
	motion.y = JUMP
	body.dano()
# Sofre dano
func _on_Dano_body_entered(body):
	VariaveisGlobais.vida_atual_alquimista -= 1
	if (VariaveisGlobais.vida_atual_alquimista <= 0):
		VariaveisGlobais.vida_atual_alquimista = VariaveisGlobais.vida_max_alquimista
		get_tree().change_scene("res://Menu.tscn")
		

