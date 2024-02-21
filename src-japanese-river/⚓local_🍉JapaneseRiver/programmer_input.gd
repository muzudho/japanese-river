# インプット（Input；入力）
extends Node


# ーーーーーーーー
# ノード・パス関連
# ーーーーーーーー

# 猿取得
func monkey():
	return $"../🐵Monkey"


# ーーーーーーーー
# メモリ関連
# ーーーーーーーー

# 仮想キーの入力状態
#
# 	キーは、プログラム内で決まりを作っておいてください。
# 	値は、ボタンを押していないとき 0、押しているとき 1、レバーは実数
#
var key_state = {
	# 決定ボタン、メッセージ送りボタン
	&"VK_Ok" : 0,
	# キャンセルボタン、メニューボタン
	&"VK_Cancel" : 0,
	# メッセージ早送りボタン
	&"VK_FastForward" : 0,
	# レバーの左右
	&"VK_Right" : 0,
	# レバーの上下
	&"VK_Down" : 0,
}


# ーーーーーーーー
# 仮想キーの入力をさばく
# ーーーーーーーー
#
# paragraph_obj の例
# =================
#
#	ボタンの押下状態や、レバーの方向によって、飛び先の段落名を指定します
#
#{
#	"¶青森県" : {
#		# ボタン押下
#		&"VK_Ok" : "¶確定",
#		# ナナメ入力は、 &"VK_Down" の中に &"VK_Right" を入れる順番にしてください
#		&"VK_Down" : {
#			# レバーは + - も指定
#			&"-" : "¶北海道",
#			&"+" : {
#				# ナナメ入力があるときに、ナナメ入力でない上下方向があるなら、バーチャル・キー名を空文字列にしてください
#				&"" : "¶秋田県",
#				&"VK_Right" : {
#					&"+" : "¶岩手県",
#				},
#			},
#		},
#	},
#},

# 仮想キー（ボタン）の入力をさばく
func parse_virtual_button_input(virtual_key_name, paragraph_obj):
	
	# まず、ボタンの押下状態を確認
	var button_value = self.key_state[virtual_key_name]

	# 押下されており、段落にも記述があるなら	
	if button_value == 1 && virtual_key_name in paragraph_obj:
		#print("［入力　シナリオ再生中の入力で］　［" + str(virtual_key_name) + "］ボタン押下。段落：" + str(paragraph_obj) + "の中に見つかりました")
		
		var target = paragraph_obj[virtual_key_name]
		
		if target != &"":
			print("［入力　シナリオ再生中の入力で］　［" + str(virtual_key_name) + "］ボタン押下。［" + str(target) + "］へ飛ぶ")
			self.monkey().of_staff().programmer().get_instruction_node(&"📗Goto").goto(target)
			# ［シナリオで］状態に戻す
			self.monkey().owner_node().current_state = &"InScenario"
		
	#else:
	#	print("［入力　シナリオ再生中の入力で］　入力：" + str(virtual_key_name) + " は、選択肢：" + str(paragraph_obj) + "の中に見つかりませんでした")


# 仮想キー（レバー）の入力をさばく
func parse_virtual_lever_input(paragraph_obj):
	var target = paragraph_obj
	
	# まず、上下を確認
	var down_lever_value = self.key_state[&"VK_Down"]
	
	# 上下方向に入力があり、段落にも上下方向の記述があるか？
	if 0 != down_lever_value && &"VK_Down" in target:
		# その下の要素へ移動
		target = target[&"VK_Down"]
		print("［入力　シナリオ再生中の入力で　レバー］　上下方向の入力［" + str(down_lever_value) + "］があり、段落にも上下方向の記述がある。段落：" + str(target))

		# 上方向にレバーが倒れており、段落にも上方向の記載があるか？
		if down_lever_value < 0 && &"-" in target:
			# ［上方向］へ移動（飛び先の段落名だ）
			target = target[&"-"]
			print("［入力　シナリオ再生中の入力で　レバー］　上向きの入力［" + str(down_lever_value) + "］があり、段落にも上向きの記述がある。段落：" + str(target))
		
		# 下方向にレバーが倒れており、段落にも下方向の記載があるか？
		elif 0 < down_lever_value && &"+" in target:
			# ［下方向］へ移動
			#
			#　まだ、以下のどちらか確定していない
			#	- 辞書
			#	- 飛び先の段落名
			target = target[&"+"]
		
			if typeof(target) == TYPE_DICTIONARY:
				print("［入力　シナリオ再生中の入力で　レバー］　下向きの入力［" + str(down_lever_value) + "］があり、段落にも下向きの記述がある。段落：" + str(target))

			else:
				print("［入力　シナリオ再生中の入力で　レバー］　下向きの入力［" + str(down_lever_value) + "］があった。飛び先：" + str(target))
		
		else:
			# 段落に記述のない入力方向なので、関数を抜けます
			#print("［入力　シナリオ再生中の入力で　レバー］　レバーの向きの記述がなかった。段落：" + str(target))
			return
	
	# ターゲットが名前型（段落名）ではないなら
	if typeof(target) == TYPE_DICTIONARY:

		# 次に、左右を確認
		var right_lever_value = self.key_state[&"VK_Right"]

		# 左右方向には入力が無いか？
		if 0 == right_lever_value:
			
			# 段落は辞書型で、キーが空文字列のものを含むか？
			if typeof(target) == TYPE_DICTIONARY:
				if &"" in target:
					# それを選ぶ（飛び先の段落名だ）
					target = target[&""]
				elif "" in target:
					# それを選ぶ（飛び先の段落名だ）
					target = target[""]
				
				print("［入力　シナリオ再生中の入力で　レバー］　左右方向に入力がなく、段落にも左右方向に入力がないときの記述があった。次の段落：" + str(target))
			
			else:
				print("［入力　シナリオ再生中の入力で　レバー］　左右方向に入力がなく、段落にも左右方向に入力がないときの記述がないから無視します。 right_lever_value:［" + str(right_lever_value) + "］　段落：" + str(target))
		
		# 左右方向に入力があり、段落にも左右方向の記述があるか？
		elif &"VK_Right" in target:
			# その下の要素へ移動
			target = target[&"VK_Right"]
			print("［入力　シナリオ再生中の入力で　レバー］　左右方向の入力［" + str(right_lever_value) + "］があり、段落にも左右方向の記述がある。段落：" + str(target))

			# 左方向にレバーが倒れており、段落にも左方向の記載があるか？
			if right_lever_value < 0 && &"-" in target:
				# ［左方向］へ移動（飛び先の段落名だ）
				target = target[&"-"]
				print("［入力　シナリオ再生中の入力で　レバー］　左向きの入力［" + str(right_lever_value) + "］があり、段落にも左向きの記述がある。段落：" + str(target))
			
			# 右方向にレバーが倒れており、段落にも右方向の記載があるか？
			elif 0 < right_lever_value && &"+" in target:
				# ［右方向］へ移動（飛び先の段落名だ）
				target = target[&"+"]
				print("［入力　シナリオ再生中の入力で　レバー］　右向きの入力［" + str(right_lever_value) + "］があり、段落にも右向きの記述がある。段落：" + str(target))

			else:
				# 段落に記述のない入力方向なので、関数を抜けます
				print("［入力　シナリオ再生中の入力で　レバー］　レバーの向きの記述がなかった。関数を抜けます。段落：" + str(target))
				return
	
	if typeof(target) == TYPE_STRING || typeof(target) == TYPE_STRING_NAME:
		print("［入力　シナリオ再生中の入力で］　レバー入力。［" + str(target) + "］へ飛ぶ")
		self.monkey().of_staff().programmer().get_instruction_node(&"📗Goto").goto(target)
		# ［シナリオで］状態に戻す
		self.monkey().owner_node().current_state = &"InScenario"
		
	else:
		#if typeof(target) == TYPE_DICTIONARY:
		#	print("［入力　シナリオ再生中の入力で］　レバー入力を検知できなかったので無視します。 辞書の中身:［" + str(target) + "］")
		#else:
		#	print("［入力　シナリオ再生中の入力で］　レバー入力を検知できなかったので無視します。 typeof(target):［" + str(typeof(target)) + "］")
			
		return


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


# 毎フレーム実行されるので、処理は軽くしたい
#
# 	入力されたキーが複数ある場合、 `_unhandled_input` が全部終わってから `_process` が呼出されることを期待する
#
func _process(delta):
	#print("［★プロセス］　delta:" + str(delta))

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

		self.parse_virtual_button_input(&"VK_Ok", paragraph_obj)
		self.parse_virtual_button_input(&"VK_Cancel", paragraph_obj)
		self.parse_virtual_button_input(&"VK_FastForward", paragraph_obj)
		self.parse_virtual_lever_input(paragraph_obj)


	# 仮想キーの入力状態のクリアー
	self.key_state[&"VK_Ok"] = 0
	self.key_state[&"VK_Cancel"] = 0
	self.key_state[&"VK_FastForward"] = 0
	self.key_state[&"VK_Right"] = 0
	self.key_state[&"VK_Down"] = 0


# テキストボックスなどにフォーカスが無いときの入力をとにかく拾う
#
#		X軸と Y軸は別々に飛んでくるので　使いにくい。斜め入力を判定するには `_process` の方を使う
#
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
		print("［入力　シナリオ再生中の入力で　アンハンドルド・インプット］　event:" + event.as_text())
		var button_number = self.monkey().key_config().input_parser_node().get_button_number_by_text(event.as_text())
		#print("［入力　シナリオ再生中の入力で］　button_number:" + str(button_number))
		var lever_value = self.monkey().key_config().input_parser_node().get_lever_value_by_text(event.as_text())
		#print("［入力　シナリオ再生中の入力で］　lever_value:" + str(lever_value))

		var virtual_key_name = self.monkey().key_config_node().get_virtual_key_name_by_button_number(button_number)
		#print("［入力　シナリオ再生中の入力で］　virtual_key_name:" + str(virtual_key_name))

		if virtual_key_name == &"VK_Ok":
			self.key_state[&"VK_Ok"] = 1

		elif virtual_key_name == &"VK_Cancel":
			self.key_state[&"VK_Cancel"] = 1

		elif virtual_key_name == &"VK_FastForward":
			self.key_state[&"VK_FastForward"] = 1

		elif virtual_key_name == &"VK_Right":
			self.key_state[&"VK_Right"] = lever_value

		elif virtual_key_name == &"VK_Down":
			self.key_state[&"VK_Down"] = lever_value
