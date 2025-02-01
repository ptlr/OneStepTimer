extends Control

signal delete_timer(timer_id)
@onready var start_cion = preload("res://icons/start.svg")
@onready var pause_icon = preload("res://icons/pause.svg")
var timer_id = 0
var timer_name = ""
var timer_record: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
func init(id: int, record):
	timer_id = id
	$"Vbc/LineEditTimerName".text = "Timer_ID: %d" % timer_id
	timer_record = record
	update_time()
func get_id():
	return timer_id
	
func update_title(timer_name):
	timer_name = timer_name
	$"Vbc/LineEditTimerName".text = timer_name
func update_time():
	var hours = timer_record / 3600
	var remainder =timer_record % 3600
	var minutes = remainder / 60
	var seconds = remainder % 60
	$"Vbc/HBoxContainer/LabelTimerDisplay".text = "%02d:%02d:%02d" % [hours, minutes, seconds]
func _on_btn_start_pause_pressed() -> void:
	if($Timer.is_stopped()):
		$"Vbc/HBoxContainer/BtnStartPause".icon = pause_icon
		$Timer.start()
	else:
		$"Vbc/HBoxContainer/BtnStartPause".icon =start_cion
		$Timer.stop()


func _on_btn_delete_pressed() -> void:
	$Timer.stop()
	delete_timer.emit(timer_id)


func _on_timer_timeout() -> void:
	timer_record += 1
	update_time()
