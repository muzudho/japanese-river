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
		var button_number = self.monkey().key_config().parser_for_input().get_button_number_by_text(event.as_text())
		print("［入力　シナリオ再生中の入力で］　button_number:" + str(button_number))
		var lever_value = self.monkey().key_config().parser_for_input().get_lever_value_by_text(event.as_text())
		print("［入力　シナリオ再生中の入力で］　lever_value:" + str(lever_value))
