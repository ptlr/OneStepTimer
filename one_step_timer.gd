extends Control

const  MAX_TIMER_COUNT = 16

@onready var timer_item_list = $VBoxContainer/ScrollContainer/VBoxContainer
@onready var TimerControl = preload("res://timer_control.tscn")

@onready var max_timer_id = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	

func get_timer_id():
	var time_count = timer_item_list.get_child_count()
	if time_count == MAX_TIMER_COUNT:
		return 0
	else:
		max_timer_id += 1
		return max_timer_id
func _on_btn_new_timer_control_pressed() -> void:
	var timer_control = TimerControl.instantiate()
	var timer_id = get_timer_id()
	if timer_id == 0:
		print("MAX TIMER LIMITE: %d" % MAX_TIMER_COUNT)
		return
	timer_control.init(timer_id, 0);
	timer_control.update_title("New timer %0d" % timer_id)
	timer_control.delete_timer.connect(_on_delete_timer)
	timer_item_list.add_child(timer_control)
func _on_delete_timer(timer_id):
	print("DELETE_ID: %d" % timer_id)
	for tcontrol in timer_item_list.get_children():
		if tcontrol.get_id() == timer_id:
			timer_item_list.remove_child(tcontrol)
			tcontrol.queue_free()
