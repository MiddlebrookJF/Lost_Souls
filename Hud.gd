extends CanvasLayer

signal start_game
signal end_game
var p1_controls
var p2_controls
var p3_controls
var p4_controls
const SECONDS_IN_MINUTE = 60

func _ready():
	
	$Pentagram.show()
	$WinLabel.hide()
	$LevelTimeLabel.hide()
	$StartButton.show()
	$ExitButton.show()
	$OptionsButton.show()
	$MessageLabel.show()
	$MessageLabel.margin_left = 752
	$MessageLabel.margin_top = 144
	$MessageLabel.margin_right = 1040
	$MessageLabel.margin_bottom = 325
	$InstructLabel.show()
	$InstructLabel/Player1Instr.modulate = Color(.533, .176, .176)
	$InstructLabel/Player2Instr.modulate = Color(.176, .176, .533)
	$InstructLabel/Player3Instr.modulate = Color(.2, .788, .25)
	$InstructLabel/Player4Instr.modulate = Color(.714, .15, .38)
	$P1_score.hide()
	$P2_score.hide()
	$P3_score.hide()
	$P4_score.hide()
	$OkayButton.hide()
	$P1_option.hide()
	$P1_option/OptLabel1.modulate = Color(.533, .176, .176)
	$P2_option.hide()
	$P2_option/OptLabel2.modulate = Color(.176, .176, .533)
	$P3_option.hide()
	$P3_option/OptLabel3.modulate = Color(.2, .788, .25)
	$P4_option.hide()
	$P4_option/OptLabel4.modulate = Color(.714, .15, .38)
	
	p1_controls = ["ui_up", "ui_left", "ui_down", "ui_right"]
	p2_controls = ["alt_up", "alt_left", "alt_down", "alt_right"]
	p3_controls = ["l0_up", "l0_left", "l0_down", "l0_right"]
	p4_controls = ["l1_up", "l1_left", "l1_down", "l1_right"]
	add_options()

func _process(delta):
	var seconds = int(floor($LevelTimer.time_left)) % SECONDS_IN_MINUTE
	var minutes = int(floor($LevelTimer.time_left)) / SECONDS_IN_MINUTE
	
	if minutes == 0 && seconds <= 10:
		if seconds % 2 == 0:
			$LevelTimeLabel.modulate = Color(1, 1, 1)
		else:
			$LevelTimeLabel.modulate = Color(.533, .176, .176)
	
	seconds = str(seconds)
	seconds = fix_seconds(seconds)

	$LevelTimeLabel.text = str(minutes) + ":" + seconds

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()

func _on_StartButton_pressed():
	
	$Pentagram.hide()
	$StartButton.hide()
	$ExitButton.hide()
	$OptionsButton.hide()
	$MessageLabel.hide()
	$InstructLabel.hide()
	$MessageLabel/Sprite.hide()
	$MessageLabel/Sprite2.hide()
	$MessageLabel/Sprite3.hide()
	$P1_score.show()
	$P2_score.show()
	$P3_score.show()
	$P4_score.show()
	
	print("p1_controls = " + p1_controls[2])
	print("p2_controls = " + p2_controls[2])
	print("p3_controls = " + p3_controls[2])
	print("p4_controls = " + p4_controls[2])
	
	emit_signal("start_game")

func _on_ExitButton_pressed():
	get_tree().quit()

func _on_OptionsButton_pressed():
	
	$Pentagram.hide()
	$StartButton.hide()
	$ExitButton.hide()
	$OptionsButton.hide()
	$MessageLabel.text = "Controls"
	$MessageLabel/Sprite.hide()
	$MessageLabel/Sprite2.hide()
	$MessageLabel/Sprite3.hide()
	$MessageLabel.margin_left = 496
	$MessageLabel.margin_top = 144
	$MessageLabel.margin_right = 784
	$MessageLabel.margin_bottom = 325
	$InstructLabel.hide()
	$OkayButton.show()
	$P1_option.show()
	$P2_option.show()
	$P3_option.show()
	$P4_option.show()

func _on_OkayButton_pressed():
	
	$Pentagram.show()
	$StartButton.show()
	$ExitButton.show()
	$OptionsButton.show()
	$MessageLabel.text = "L o s t\nSouls"
	$MessageLabel/Sprite.show()
	$MessageLabel/Sprite2.show()
	$MessageLabel/Sprite3.show()
	$MessageLabel.margin_left = 752
	$MessageLabel.margin_top = 144
	$MessageLabel.margin_right = 1040
	$MessageLabel.margin_bottom = 325
	$InstructLabel.show()
	$OkayButton.hide()
	$P1_option.hide()
	$P2_option.hide()
	$P3_option.hide()
	$P4_option.hide()
	
	p1_controls = set_controls(1)
	p2_controls = set_controls(2)
	p3_controls = set_controls(3)
	p4_controls = set_controls(4)

func add_options():
	
	$P1_option.add_item("Arrow Keys", 1)
	$P1_option.add_item("WASD Keys", 2)
	$P1_option.add_item("Controller One L", 3)
	$P1_option.add_item("Controller One R", 4)
	$P1_option.add_item("Controller Two L", 5)
	$P1_option.add_item("Controller Two R", 6)
	
	$P2_option.add_item("WASD Keys", 1)
	$P2_option.add_item("Arrow Keys", 2)
	$P2_option.add_item("Controller One L", 3)
	$P2_option.add_item("Controller One R", 4)
	$P2_option.add_item("Controller Two L", 5)
	$P2_option.add_item("Controller Two R", 6)
	
	$P3_option.add_item("Controller One L", 1)
	$P3_option.add_item("Arrow Keys", 2)
	$P3_option.add_item("WASD Keys", 3)
	$P3_option.add_item("Controller One R", 4)
	$P3_option.add_item("Controller Two L", 5)
	$P3_option.add_item("Controller Two R", 6)
	
	$P4_option.add_item("Controller One R", 1)
	$P4_option.add_item("Arrow Keys", 2)
	$P4_option.add_item("WASD Keys", 3)
	$P4_option.add_item("Controller One L", 4)
	$P4_option.add_item("Controller Two L", 5)
	$P4_option.add_item("Controller Two R", 6)
	
func set_controls(player):
	var ret_controls
	
	match player:
		1:	match $P1_option.get_selected_id():
			1:	ret_controls = ["ui_up", "ui_left", "ui_down", "ui_right"]
			2:	ret_controls = ["alt_up", "alt_left", "alt_down", "alt_right"]
			3:	ret_controls = ["l0_up", "l0_left", "l0_down", "l0_right"]
			4:	ret_controls = ["r0_up", "r0_left", "r0_down", "r0_right"]
			5:	ret_controls = ["l1_up", "l1_left", "l1_down", "l1_right"]
			6:	ret_controls = ["r1_up", "r1_left", "r1_down", "r1_right"]
			_:	ret_controls = ["ui_up", "ui_left", "ui_down", "ui_right"]
		2:	match $P2_option.get_selected_id():
			1:	ret_controls = ["alt_up", "alt_left", "alt_down", "alt_right"]
			2:	ret_controls = ["ui_up", "ui_left", "ui_down", "ui_right"]
			3:	ret_controls = ["l0_up", "l0_left", "l0_down", "l0_right"]
			4:	ret_controls = ["r0_up", "r0_left", "r0_down", "r0_right"]
			5:	ret_controls = ["l1_up", "l1_left", "l1_down", "l1_right"]
			6:	ret_controls = ["r1_up", "r1_left", "r1_down", "r1_right"]
			_:	ret_controls = ["alt_up", "alt_left", "alt_down", "alt_right"]
		3:	match $P3_option.get_selected_id():
			1:	ret_controls = ["l0_up", "l0_left", "l0_down", "l0_right"]
			2:	ret_controls = ["ui_up", "ui_left", "ui_down", "ui_right"]
			3:	ret_controls = ["alt_up", "alt_left", "alt_down", "alt_right"]
			4:	ret_controls = ["r0_up", "r0_left", "r0_down", "r0_right"]
			5:	ret_controls = ["l1_up", "l1_left", "l1_down", "l1_right"]
			6:	ret_controls = ["r1_up", "r1_left", "r1_down", "r1_right"]
			_:	ret_controls = ["l0_up", "l0_left", "l0_down", "l0_right"]
		4:	match $P4_option.get_selected_id():
			1:	ret_controls = ["r0_up", "r0_left", "r0_down", "r0_right"]
			2:	ret_controls = ["ui_up", "ui_left", "ui_down", "ui_right"]
			3:	ret_controls = ["alt_up", "alt_left", "alt_down", "alt_right"]
			4:	ret_controls = ["l0_up", "l0_left", "l0_down", "l0_right"]
			5:	ret_controls = ["l1_up", "l1_left", "l1_down", "l1_right"]
			6:	ret_controls = ["r1_up", "r1_left", "r1_down", "r1_right"]
			_:	ret_controls = ["r0_up", "r0_left", "r0_down", "r0_right"]
	
	return ret_controls

func _on_LevelTimer_timeout():
	$LevelTimeLabel.hide()
	emit_signal("end_game")
	$LevelTimeLabel.modulate = Color(1, 1, 1)

func fix_seconds(seconds):
	var size = seconds.length()
	var ret_seconds
	
	for i in range(size):
		#if the string for the seconds is less than 2 digits, add a 0
		if(size < 2):
			ret_seconds = str("0",seconds[i])
		#else, return the same digits
		else:
			ret_seconds = str(seconds[i-1],seconds[i])
	return ret_seconds
