# インプット（Input；入力）
extends Node


# ーーーーーーーー
# ノード・パス関連
# ーーーーーーーー

# 猿取得
func monkey():
	return $"../🐵Monkey"


# ーーーーーーーー
# 入力
# ーーーーーーーー

# テキストボックスなどにフォーカスが無いときのキー入力を拾う
#
# 子要素から親要素の順で呼び出されるようだ。
# このプログラムでは　ルート　だけで　キー入力を拾うことにする
func _unhandled_key_input(event):
	# ［まだ準備ができていません］
	if self.monkey().owner_node().current_state == &"NotReadyYet":
		pass

	# ［キー・コンフィグで］は、何もするな
	elif self.monkey().owner_node().current_state == &"InKeyConfig":
		pass

	# ［シナリオで］状態
	elif self.monkey().owner_node().current_state == &"InScenario":
		self.monkey().scenario_player().input_node().on_unhandled_key_input(event)

	# ［シナリオ再生中の入力で］状態
	elif self.monkey().owner_node().current_state == &"InScenarioPlayingInput":
		print("［キー入力　シナリオ再生中の入力で］　event:" + str(event))
		pass


# テキストボックスなどにフォーカスが無いときの入力をとにかく拾う
func _unhandled_input(event):
	# ［まだ準備ができていません］
	if self.monkey().owner_node().current_state == &"NotReadyYet":
		pass

	# ［キー・コンフィグで］状態
	elif self.monkey().owner_node().current_state == &"InKeyConfig":
		self.monkey().key_config_node().on_unhandled_input(event)

	# ［シナリオで］状態
	elif self.monkey().owner_node().current_state == &"InScenario":
		self.monkey().scenario_player().input_node().on_unhandled_input(event)

	# ［シナリオ再生中の入力で］状態
	elif self.monkey().owner_node().current_state == &"InScenarioPlayingInput":
		print("［入力　シナリオ再生中の入力で］　event:" + event.as_text())
		var button_number = self.monkey().key_config().input_parser_node().get_button_number_by_text(event.as_text())
		print("［入力　シナリオ再生中の入力で］　button_number:" + str(button_number))
		var lever_value = self.monkey().key_config().input_parser_node().get_lever_value_by_text(event.as_text())
		print("［入力　シナリオ再生中の入力で］　lever_value:" + str(lever_value))

		var button_virtual_key = self.monkey().key_config_node().get_virtual_key_name_by_button_number(button_number)
		print("［入力　シナリオ再生中の入力で］　button_virtual_key:" + str(button_virtual_key))

		var department_value = self.monkey().scenario_player_node().get_current_department_value()
		var department_name = str(department_value.name)
		var paragraph_name = department_value.paragraph_name

		# 辞書
		var choices_mappings_a = self.monkey().scenario_player_node().get_merged_choices_mappings(department_name)
		
		# 段落配列。実質的には選択肢の配列
		var paragraph_obj = choices_mappings_a[paragraph_name]
		print("［入力　シナリオ再生中の入力で］　段落：" + str(paragraph_obj))

		# paragraph_obj の例
		#{
		#	# TODO ボタンの押下状態や、レバーの整数値によって、飛び先を制御したい
		#	# TODO 以下は例。レバーは + - も指定
		#	&"VK_Ok" : "¶確定",
		#	&"VK_Down" : {
		#		&"+" : "¶青森県",
		#	},
		#},

		if button_virtual_key in paragraph_obj:
			print("［入力　シナリオ再生中の入力で］　入力：" + str(button_virtual_key) + " は、選択肢：" + str(paragraph_obj) + "の中に見つかりました")
			
			var target = paragraph_obj[button_virtual_key]

			if button_virtual_key == "VK_Right" or button_virtual_key == "VK_Down":
				
				# TODO レバーを倒せば、レバーをニュートラルに戻す操作も続いて出てくるが、そこまで細かく対応していない。対応する必要があったら改造する
				if 0 < lever_value and &"+" in target:
					target = target[&"+"]
					
				elif lever_value < 0 and &"-" in target:
					target = target[&"-"]
										
				else:
					# レバーをニュートラルに戻したとき
					target = &""
			
			if target != &"":
				print("［入力　シナリオ再生中の入力で］　飛び先：［" + str(target) + "］へ飛びたい")
			
		else:
			print("［入力　シナリオ再生中の入力で］　入力：" + str(button_virtual_key) + " は、選択肢：" + str(paragraph_obj) + "の中に見つかりませんでした")
			
