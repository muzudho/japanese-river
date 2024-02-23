# インプット　＞　エクステンション（Extension；拡張）
extends Node


# ーーーーーーーー
# ノード・パス関連
# ーーーーーーーー

# 猿取得
func monkey():
	return $"../../🐵Monkey"

# オーナー取得
func owner_node():
	return $"../../🕹️Input"


# ーーーーーーーー
# イベント・ハンドラー
# ーーーーーーーー

func on_process(_delta):
	# ［シナリオ再生中の入力で］状態
	if self.monkey().owner_node().current_state == &"InScenarioPlayingInput":
		var department_value = self.monkey().scenario_player_node().get_current_department_value()
		var department_name_str = str(department_value.name)
		#print("［入力　シナリオ再生中の入力で］　部門名：" + department_name_str)
		var paragraph_name = department_value.paragraph_name
		#print("［入力　シナリオ再生中の入力で］　段落名：" + str(paragraph_name))

		# 辞書
		var choices_mappings_a = self.monkey().scenario_player_node().get_merged_choices_mappings(department_name_str)
		
		# 段落配列。実質的には選択肢の配列
		#print("［入力　シナリオ再生中の入力で］　辞書：" + str(choices_mappings_a))
		var paragraph_obj = choices_mappings_a[paragraph_name]
		#print("［入力　シナリオ再生中の入力で　プロセス］　段落：" + str(paragraph_obj))

		self.owner_node().parse_virtual_button_input(&"VK_Ok", paragraph_obj)
		self.owner_node().parse_virtual_button_input(&"VK_Cancel", paragraph_obj)
		self.owner_node().parse_virtual_button_input(&"VK_FastForward", paragraph_obj)
		self.owner_node().parse_virtual_lever_input(paragraph_obj)


func on_handled_input(event):
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
		pass


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
