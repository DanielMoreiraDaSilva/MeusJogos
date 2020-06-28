extends ProgressBar

var alquimista

func _ready():
	alquimista = get_tree().get_nodes_in_group("Player")[0]
	
func _physics_process(delta):
	
	max_value = VariaveisGlobais.vida_max_alquimista
	
	value = VariaveisGlobais.vida_atual_alquimista
