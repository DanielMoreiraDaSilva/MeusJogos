extends StaticBody2D

var flip = false
var posicaoInicial
var posicaoFinal
var velocidade = 4
var vidaMonstro = 4

func _ready():
	$AnimatedSprite.play("Run")
	posicaoInicial = $".".position.x
	posicaoFinal = posicaoInicial + 200
	
	
func _process(delta):
	
	if (flip == false):
		$".".position.x += velocidade
		$AnimatedSprite.flip_h = true
		if ($".".position.x >= posicaoFinal):
			flip = true
			
	else:
		$".".position.x -= velocidade
		$AnimatedSprite.flip_h = false
		if ($".".position.x <= posicaoInicial):
			flip = false


func dano():
	vidaMonstro -= 1
	get_node("AnimationPlayer").play("DanoMonstro")
	if vidaMonstro <= 0 :
	 get_node("AnimationPlayer").play("morte")
	
func morte():
	$".".queue_free()
