extends Area2D

var posicao
var velocidade = 10

func _process(delta):
	$".".position.x += velocidade
	

func _on_BolaDeFogo_body_entered(body):
	print("ta rolando")
	body.dano()
	$".".queue_free()
