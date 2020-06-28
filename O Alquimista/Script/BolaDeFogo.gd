extends StaticBody2D

var posicao
var velocidade = 10

func _ready():
	set_process(true)
	posicao = $".".position
	
	
func _process(delta):
	$".".position.x += velocidade
	
	if $".".position.x >= posicao.x + 500:
		queue_free()
		
	elif $".".position.x <= posicao.x -500:		
		queue_free()
		
	if velocidade == -10:
		$Sprite.flip_h = true;
		


func _on_Area2D_body_entered(body):
	body.dano()

func _on_Area2D2_body_entered(body):
	queue_free()
