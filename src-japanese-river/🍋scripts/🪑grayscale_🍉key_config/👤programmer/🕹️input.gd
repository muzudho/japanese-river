# インプット（Input；入力）
extends Node


# ーーーーーーーー
# ノード・パス関連
# ーーーーーーーー

# 猿取得
func monkey():
	return $"../🐵Monkey"


# 拡張ノード取得
func extension_node():
	return $"Extension"


# ーーーーーーーー
# メモリ関連
# ーーーーーーーー

# 仮想キー辞書
#
#	オカレンス（Occurence；起こった）について
#		- ［押下］（Pressed）と［解放］（Released）は検知できる
#		- アナログの場合、完全な押下を［押下］、完全な解放を［解放］と呼ぶことにする
#		- 何も検知していないとき［ナン］（None；無し）とする
#
#	ドゥ―リング（During；その間）について
#		- ［押しっぱなし］（Pressing）は検知できない
#		- ［押下］後、次の［解放］までの期間を［押しっぱなし］と考える必要がある
#		- ［放しっぱなし］も同様
#
#	レバー・ディレクション（Lever Direction；レバーの向き）について
#		- [-1.0 ～ 1.0] の範囲があるが、ぴったり 0 になることは稀
#		- 例えば (-0.2 ～ 0.2) を［解放］とするようなレンジが要る
#
#	ステート
#		- ボタンや、キーボードのキーなら、［解放］を 0 、［押下］を 1
#		- Ｘ軸レバーなら、右方向を正として [-1.0 ～ 1.0]
#		- Ｙ軸レバーなら、下方向を正として [-1.0 ～ 1.0]
#
# 辞書
# 	キー：　プログラム内で決まりを作っておいてください。
# 	値：　以下、それぞれ説明
#
#		［０］　オカレンス。初期値は &"None" とする
#			&"None"：	何も検知していない
#			&"Pressed"：	［押下］を検知
#			&"Release"：［解放］を検知
#
#		［１］　ドゥ―リング。初期値は &"Neutral" とする
#			&"Neutral"：		［解放］を検知したあと、まだ［押下］を検知していない間
#			&"Pressing"：	［押下］を検知したあと、まだ［解放］を検知していない間
#
#		［２］　ステート
#			ボタン：　整数。［解放］のとき 0、 ［押下］のとき 1、 何もしていないとき、前の値を維持
#			レバー：　実数。-1.0 ～ 1.0。 何もしていないとき、前の値を維持
#
var key_record = {
	# 決定ボタン、メッセージ送りボタン
	&"VK_Ok" : [&"None", &"Neutral", 0.0],
	# キャンセルボタン、メニューボタン
	&"VK_Cancel" : [&"None", &"Neutral", 0.0],
	# メッセージ早送りボタン
	&"VK_FastForward" : [&"None", &"Neutral", 0.0],
	# ボタンの右、または、レバーの左右
	&"VK_Right" : [&"None", &"Neutral", 0.0],
	# ボタンの左
	#&"VK_Left"	
	# ボタンの下、または、レバーの上下
	&"VK_Down" : [&"None", &"Neutral", 0.0],
	# ボタンの上
	#&"VK_Up"
}


func get_occurence(vk_name):
	return self.key_record[vk_name][0]


func set_occurence(vk_name, value):
	self.key_record[vk_name][0] = value


func get_during(vk_name):
	return self.key_record[vk_name][1]


func set_during(vk_name, value):
	self.key_record[vk_name][1] = value


func get_state(vk_name):
	return self.key_record[vk_name][2]


func set_state(vk_name, value):
	self.key_record[vk_name][2] = value


# ーーーーーーーー
# 毎フレーム処理
# ーーーーーーーー

# 毎フレーム実行されるので、処理は軽くしたい
#
# 	入力されたキーが複数ある場合、 `_unhandled_input` が全部終わってから `_process` が呼出されることを期待する
#
func _process(delta):
	#print("［★プロセス］　delta:" + str(delta))

	# 拡張
	self.extension_node().on_process(delta)

	# 拡張処理のあとに
	# 仮想キーの状態変化の解析
	self.end_of_process_by_virtual_key(&"VK_Ok")
	self.end_of_process_by_virtual_key(&"VK_Cancel")
	self.end_of_process_by_virtual_key(&"VK_FastForward")
	self.end_of_process_by_virtual_key(&"VK_Right")
	self.end_of_process_by_virtual_key(&"VK_Down")


# 毎フレーム実行されます
#
# Parameters
# ==========
# * `vk_name` - Virtual key name
func end_of_process_by_virtual_key(vk_name):
	# 状態変化はどうなったか？
	var vk_state = self.get_state(vk_name)
	var abs_vk_state = abs(vk_state)
	var vk_occurence = self.get_occurence(vk_name)
	var vk_during = self.get_during(vk_name)

	# オカレンスは毎フレーム、クリアーします
	self.set_occurence(vk_name, &"None")

	# 以下、デバッグ出力
	if vk_occurence == &"Released" || vk_during == &"Neutral":
		# 放しているのにボタン値が 1 というのは矛盾してる
		if 1 <= abs_vk_state:
			print("［入力　process_virtual_key］　［" + vk_name +"］キーについて、解放状態から押下確定 vk_occurence:" + vk_occurence + " vk_during:" + vk_during)
			return
		
		if 0 < abs_vk_state && abs_vk_state < 1:
			print("［入力　process_virtual_key］　［" + vk_name +"］キーについて、解放状態から押下浮遊 vk_occurence:" + vk_occurence + " vk_during:" + vk_during)
			return
		
		if vk_occurence == &"Released":
			print("［入力　process_virtual_key］　［" + vk_name +"］キーについて、解放からニュートラルへ vk_occurence:" + vk_occurence + " vk_during:" + vk_during)
			return

	elif vk_occurence == &"Pressed" || vk_during == &"Pressing":
		# TODO 押しっぱなしにすると、最初の１回（Pressed）しかイベントが発生しない。２フレーム後には ボタン値は 0 にクリアーされてしまう
		# 押しているときに ボタン値が 0 というのは矛盾してる
		if 0 == abs_vk_state:
			print("［入力　process_virtual_key］　［" + vk_name +"］キーについて、押下状態から解放確定 vk_occurence:" + vk_occurence + " vk_during:" + vk_during)
			return
			
		if 0 < abs_vk_state && abs_vk_state < 1:
			print("［入力　process_virtual_key］　［" + vk_name +"］キーについて、押下状態から解放浮遊 vk_occurence:" + vk_occurence + " vk_during:" + vk_during)
			return
			
		if vk_occurence == &"Pressed":
			print("［入力　process_virtual_key］　［" + vk_name +"］キーについて、押下から押しっぱなしへ vk_occurence:" + vk_occurence + " vk_during:" + vk_during)
			return
	
	# 継続
	pass


# ーーーーーーーー
# 入力
# ーーーーーーーー

# テキストボックスなどにフォーカスが無いときのキー入力を拾う
#
# 子要素から親要素の順で呼び出されるようだ。
# このプログラムでは　ルート　だけで　キー入力を拾うことにする
func _unhandled_key_input(event):
	print("［入力　アンハンドルド・キー・インプット］　開始　event_as_text:" + event.as_text())
	
	self.on_key_changed(event)

	# 拡張
	self.extension_node().on_unhandled_key_input(event)


# テキストボックスなどにフォーカスが無いときの入力をとにかく拾う
#
#	- X軸と Y軸は別々に飛んでくるので　使いにくい。斜め入力を判定するには `_process` の方を使う
#	- ボタンの押下と解放を区別できるか？
#
func _unhandled_input(event):
	print("［入力　アンハンドルド・インプット］　開始　event_as_text:" + event.as_text())
	
	self.on_key_changed(event)
	# 拡張
	self.extension_node().on_unhandled_input(event)


# キー入力を受け取り、その状態を記憶します
#
#	FIXME キー入力ではないのに呼出されているケースがある？
#
func on_key_changed(event):
	# キー入力を受け取り、その状態を記憶します
	var button_symbol = self.monkey().key_config().input_parser_node().get_button_symbol_by_text(event.as_text())

	# Virtual key name
	var vk_name = self.monkey().key_config_node().get_virtual_key_name_by_hardware_symbol(button_symbol)
	
	# 仮想キー名が取れなかったら無視します
	if vk_name == &"":
		print("［入力解析　on_key_changed］　仮想キー名が無いイベントは、無視します　vk_name:" + str(vk_name) + "　event_as_text:" + event.as_text())
		return
	

	# レバーでなければ 0.0 を返す
	var lever_value = self.monkey().key_config().input_parser_node().get_lever_value_by_text(event.as_text())

	# ボタンか？
	if typeof(button_symbol) != TYPE_STRING:
		# ボタンか？
		if button_symbol < 1000:
			if event.is_pressed():
				print("［入力解析　on_key_changed］ ボタンを押したか？　event:" + event.as_text() + " button_symbol:" + str(button_symbol) + " vk_name:" + str(vk_name) + " lever_value:" + str(lever_value))
				self.set_state(vk_name, 1)
				self.set_occurence(vk_name, &"Pressed")
				self.set_during(vk_name, &"Pressing")
				return
				
			elif event.is_released():
				print("［入力解析　on_key_changed］　ボタンを放したか？　event:" + event.as_text() + " button_symbol:" + str(button_symbol) + " vk_name:" + str(vk_name) + " lever_value:" + str(lever_value))
				self.set_state(vk_name, 0)
				self.set_occurence(vk_name, &"Released")
				self.set_during(vk_name, &"Neutral")
				return
				
		# レバーかも
		else:
			if 1 <= abs(lever_value):
				print("［入力解析　on_key_changed］　レバーを倒したか？　event:" + event.as_text() + " button_symbol:" + str(button_symbol) + " vk_name:" + str(vk_name) + " lever_value:" + str(lever_value))
				self.set_state(vk_name, lever_value)
				self.set_occurence(vk_name, &"Pressed")
				self.set_during(vk_name, &"Pressing")
				return
			
			# ぴったり 0 になることは難しいのでレンジで指定する
			elif abs(lever_value) < 0.2:
				print("［入力解析　on_key_changed］　レバーを元に戻したか？　event:" + event.as_text() + " button_symbol:" + str(button_symbol) + " vk_name:" + str(vk_name) + " lever_value:" + str(lever_value))
				self.set_state(vk_name, lever_value)
				self.set_occurence(vk_name, &"Released")
				self.set_during(vk_name, &"Neutral")
				return
				
			else:
				print("［入力解析　on_key_changed］　レバーをアナログ操作中か？　event:" + event.as_text() + " button_symbol:" + str(button_symbol) + " vk_name:" + str(vk_name) + " lever_value:" + str(lever_value))
				self.set_state(vk_name, lever_value)
				# 状態はキープ
				return
				
	# キーボードのキーか？
	else:
		if event.is_pressed():
			print("［入力解析　on_key_changed］　キーボードのキーを押したか？　event:" + event.as_text() + " button_symbol:" + str(button_symbol) + " vk_name:" + str(vk_name) + " lever_value:" + str(lever_value))
			self.set_state(vk_name, 1)
			self.set_occurence(vk_name, &"Pressed")
			self.set_during(vk_name, &"Pressing")
			return
			
		elif event.is_released():
			print("［入力解析　on_key_changed］　キーボードのキーを放したか？　event:" + event.as_text() + " button_symbol:" + str(button_symbol) + " vk_name:" + str(vk_name) + " lever_value:" + str(lever_value))
			self.set_state(vk_name, 0)
			self.set_occurence(vk_name, &"Released")
			self.set_during(vk_name, &"Neutral")
			return

	# 入力を検知できなかったなら
	self.set_occurence(vk_name, &"None")
	# その他は維持


# 上キーが入力されたか？
#
#	（レバーではなく）上キーと下キーに別々にボタンを設定しているケースがある
#
# Parameters
# ==========
# * `vk_name` - Virtual key name
# * `vk_state` - Lever value
func is_key_up(
		vk_name,
		vk_state):

	if vk_name == &"VK_Up":
		print("［キー入力］　上キー押下")
		return true

	if vk_name == &"VK_Down" and vk_state < 0:
		print("［キー入力］　下キー押下、かつ　Ｙ軸レバーをマイナス方向に倒した")
		return true

	print("［キー入力］　上キー押下ではない。 vk_name:" + vk_name + " vk_state:" + str(vk_state))
	return false


# 下キーが入力されたか？
#
#	（レバーではなく）上キーと下キーに別々にボタンを設定しているケースがある
#
# Parameters
# ==========
# * `vk_name` - Virtual key name
# * `vk_state` - Lever value
func is_key_down(
		vk_name,
		vk_state):
	
	if vk_name == &"VK_Down" and 0 < vk_state:
		print("［キー入力］　下キー押下、かつ　Ｙ軸レバーをプラス方向に倒した")
		return true

	print("［キー入力］　下キー押下ではない。 vk_name:" + vk_name + " vk_state:" + str(vk_state))
	return false


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
func parse_virtual_button_input(
		vk_name,
		paragraph_obj):
	
	# まず、ボタンの押下状態を確認
	var vk_occurence = self.get_occurence(vk_name)

	# 押下されており、段落にも記述があるなら	
	if vk_occurence == &"Pressed" && vk_name in paragraph_obj:
		#print("［入力　シナリオ再生中の入力で］　［" + str(vk_name) + "］ボタン押下。段落：" + str(paragraph_obj) + "の中に見つかりました")
		
		var target = paragraph_obj[vk_name]
		
		if target != &"":
			print("［入力　シナリオ再生中の入力で］　［" + str(vk_name) + "］ボタン押下。［" + str(target) + "］へ飛ぶ")
			self.monkey().of_staff().programmer().get_instruction_node(&"📗Goto").goto(target)
			# ［シナリオで］状態に戻す
			self.monkey().owner_node().current_state = &"InScenario"
		
	#else:
	#	print("［入力　シナリオ再生中の入力で］　入力：" + str(vk_name) + " は、選択肢：" + str(paragraph_obj) + "の中に見つかりませんでした")


# 仮想キー（レバー）の入力をさばく
func parse_virtual_lever_input(
		paragraph_obj):
	var target = paragraph_obj
	
	# まず、上下を確認
	var down_lever_value = self.get_state(&"VK_Down")
	
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
		var right_lever_value = self.get_state(&"VK_Right")

		# 左右方向には入力が無いか？
		if 0 == right_lever_value:
			
			# 段落は辞書型で、キーが空文字列のものを含むか？
			if typeof(target) == TYPE_DICTIONARY:
				if &"" in target:
					# FIXME ここにはこない？？
					# それを選ぶ（飛び先の段落名だ）
					target = target[&""]
				elif "" in target:
					# それを選ぶ（飛び先の段落名だ）
					target = target[""]
				
				#print("［入力　シナリオ再生中の入力で　レバー］　左右方向に入力がなく、段落にも左右方向に入力がないときの記述があった。次の段落：" + str(target))
			
			#else:
			#	print("［入力　シナリオ再生中の入力で　レバー］　左右方向に入力がなく、段落にも左右方向に入力がないときの記述がないから無視します。 right_lever_value:［" + str(right_lever_value) + "］　段落：" + str(target))
		
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
