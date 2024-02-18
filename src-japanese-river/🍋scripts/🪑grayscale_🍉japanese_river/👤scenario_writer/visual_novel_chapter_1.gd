# ユーザー・デファインド・ファイル（User defined file；利用者定義書類）
extends Node


# ーーーーーーーー
# メモリ関連
# ーーーーーーーー


var ancestor_children_dictionary = {}


# ーーーーーーーー
# 親パス関連
# ーーーーーーーー


# シナリオライターズ・ハブ取得
func monkey():
	return MonkeyHelper.find_ancestor_child(
			self,
			"👤ScenarioWriter/🐵Monkey_🍉VisualNovel",
			self.ancestor_children_dictionary)


# ーーーーーーーー
# その他
# ーーーーーーーー

# 台本
#
# 	- この scenario_document` という変数名は変えないでください
#	- ファイル名は変えても構いません
#	- `📗～部門` ノードにぶら下がっているファイルを読みに行きます
#	- この書き方だと、実はインデントのタブが台詞データとして入っていますが、プログラム側で省きます
#
var scenario_document = {

	# このキーは［段落名］と呼ぶことにします
	#
	#	- 頭に「¶」を付けているのは見やすさのためで、付けなくても構いません
	#	- `📗～部門` ノードにぶら下がっている他のファイルの scenario_document` のセクション名と被らないように運用してください
	#
	"¶タイトル画面":[
		"""\
		!
		bg_music:	🎵タイトル
		telop:		Ｔタイトル
		img:		🗻崎川駅前
		# 先にメッセージ・ウィンドウを指定してから、選択肢を設定してください
		msg_wnd:	■下
		choice:		1,2
		""",
		"""\
		　・スタート
		　・終了
		""",
	],
	# 終わるなら
	"¶終了" : [
		"""\
		!
		quit:
		"""
	],
	# ゲーム開始
	"¶はじまり":[
		"""\
		!
		telop:	Ｔタイトル, hide
		""",
		# ２３４５６７８９０１２３４５６７８９０
		"""\
		きふわらべ
		「お前は日本の川の名前を知っているか？
		""",
		# ２３４５６７８９０１２３４５６７８９０
		"""\
		!
		img:	🗻崎川駅前, hide
		img:	🗻畳み
		img:	🗻日本
		""",
		# ２３４５６７８９０１２３４５６７８９０
		"""\
		きふわらべ
		「日本一長い川がある県を選べだぜ」
		""",
		# 関数のテスト
		func():
			# これはそのまま通り抜ける
			pass,
		"""\
		!
		# 何も選択していないと後でエラーになるので、ダミーを入れておく
		var:	selected_image,		🗻01北海道
		goto:	¶北海道
		""",
	],
	"¶北海道":[
		"""\
		!
		img:	{{selected_image}},		hide
		var:	  selected_image,		🗻01北海道
		img:	{{selected_image}}
		""",
		# 関数のテスト
		func():
			# ここで入力を待つにはどうする？
			# ［シナリオ再生中の入力で］状態へ移行
			print("［シナリオ　はじまり］　［シナリオ再生中の入力で］状態へ移行")
			self.monkey().of_staff().programmer().owner_node().current_state = &"InScenarioPlayingInput"
			# TODO 決定ボタンを押したら "¶確定" へ移動したい
			# TODO 下キーを押したら "¶青森" へ移動したい
			pass,
		"""\
		!
		choice:	1, 2
		""",
		"""\
		　確定
		　青森県
		""",
	],
	"¶青森県":[
		"""\
		!
		img:	{{selected_image}},		hide
		var:	  selected_image,		🗻02青森県
		img:	{{selected_image}}
		choice:	1, 2, 3, 4
		""",
		"""\
		　確定
		　北海道
		　秋田県
		　岩手県
		""",
	],
	"¶秋田県":[
		"""\
		!
		img:	{{selected_image}},		hide
		var:	  selected_image,		🗻05秋田県
		img:	{{selected_image}}
		choice:	1, 2, 3, 4, 5
		""",
		"""\
		　確定
		　青森県
		　岩手県
		　宮城県
		　山形県
		""",
	],
	"¶岩手県":[
		"""\
		!
		img:	{{selected_image}},		hide
		var:	  selected_image,		🗻03岩手県
		img:	{{selected_image}}
		choice:	1, 2, 3, 4
		""",
		"""\
		　確定
		　青森県
		　宮城県
		　秋田県
		""",
	],
	"¶山形県":[
		"""\
		!
		img:	{{selected_image}},		hide
		var:	  selected_image,		🗻06山形県
		img:	{{selected_image}}
		choice:	1, 2, 3, 4, 5
		""",
		"""\
		　確定
		　秋田県
		　宮城県
		　福島県
		　新潟県
		""",
	],
	"¶宮城県":[
		"""\
		!
		img:	{{selected_image}},		hide
		var:	  selected_image,		🗻04宮城県
		img:	{{selected_image}}
		choice:	1, 2, 3, 4, 5
		""",
		"""\
		　確定
		　岩手県
		　福島県
		　山形県
		　秋田県
		""",
	],
	"¶福島県":[
		"""\
		!
		img:	{{selected_image}},		hide
		var:	  selected_image,		🗻07福島県
		img:	{{selected_image}}
		choice:	1, 2, 3, 4, 5, 6, 7
		""",
		"""\
		　確定
		　山形県
		　宮城県
		　茨城県
		　栃木県
		　群馬県
		　新潟県
		""",
	],
	"¶群馬県":[
		"""\
		!
		img:	{{selected_image}},		hide
		var:	  selected_image,		🗻10群馬県
		img:	{{selected_image}}
		choice:	1, 2, 3, 4, 5, 6
		""",
		"""\
		　確定
		　新潟県
		　福島県
		　栃木県
		　埼玉県
		　長野県
		""",
	],
	"¶栃木県":[
		"""\
		!
		img:	{{selected_image}},		hide
		var:	  selected_image,		🗻09栃木県
		img:	{{selected_image}}
		choice:	1, 2, 3, 4, 5
		""",
		"""\
		　確定
		　福島県
		　茨城県
		　埼玉県
		　群馬県
		""",
	],
	"¶茨城県":[
		"""\
		!
		img:	{{selected_image}},		hide
		var:	  selected_image,		🗻08茨城県
		img:	{{selected_image}}
		choice:	1, 2, 3, 4, 5
		""",
		"""\
		　確定
		　福島県
		　千葉県
		　埼玉県
		　栃木県
		""",
	],
	"¶千葉県":[
		"""\
		!
		img:	{{selected_image}},		hide
		var:	  selected_image,		🗻12千葉県
		img:	{{selected_image}}
		choice:	1, 2, 3, 4, 5
		""",
		"""\
		　確定
		　茨城県
		　神奈川県
		　東京都
		　埼玉県
		""",
	],
	"¶埼玉県":[
		"""\
		!
		img:	{{selected_image}},		hide
		var:	  selected_image,		🗻11埼玉県
		img:	{{selected_image}}
		choice:	1, 2, 3, 4, 5, 6, 7, 8
		""",
		"""\
		　確定
		　群馬県
		　栃木県
		　茨城県
		　千葉県
		　東京都
		　山梨県
		　長野県
		""",
	],
	"¶東京都":[
		"""\
		!
		img:	{{selected_image}},		hide
		var:	  selected_image,		🗻13東京都
		img:	{{selected_image}}
		choice:	1, 2, 3, 4, 5
		""",
		"""\
		　確定
		　埼玉県
		　千葉県
		　神奈川県
		　山梨県
		""",
	],
	"¶神奈川県":[
		"""\
		!
		img:	{{selected_image}},		hide
		var:	  selected_image,		🗻14神奈川県
		img:	{{selected_image}}
		choice:	1, 2, 3, 4
		""",
		"""\
		　確定
		　東京都
		　静岡県
		　山梨県
		""",
	],
	"¶新潟県":[
		"""\
		!
		img:	{{selected_image}},		hide
		var:	  selected_image,		🗻15新潟県
		img:	{{selected_image}}
		choice:	1, 2, 3, 4, 5, 6
		""",
		"""\
		　確定
		　山形県
		　福島県
		　群馬県
		　長野県
		　富山県
		""",
	],
	"¶長野県":[
		"""\
		!
		img:	{{selected_image}},		hide
		var:	  selected_image,		🗻20長野県
		img:	{{selected_image}}
		choice:	1, 2, 3, 4, 5, 6, 7, 8, 9
		""",
		"""\
		　確定
		　新潟県
		　群馬県
		　埼玉県
		　山梨県
		　静岡県
		　愛知県
		　岐阜県
		　富山県
		""",
	],
	"¶富山県":[
		"""\
		!
		img:	{{selected_image}},		hide
		var:	  selected_image,		🗻16富山県
		img:	{{selected_image}}
		choice:	1, 2, 3, 4, 5
		""",
		"""\
		　確定
		　新潟県
		　長野県
		　岐阜県
		　石川県
		""",
	],
	"¶石川県":[
		"""\
		!
		img:	{{selected_image}},		hide
		var:	  selected_image,		🗻17石川県
		img:	{{selected_image}}
		choice:	1, 2, 3, 4
		""",
		"""\
		　確定
		　富山県
		　岐阜県
		　福井県
		""",
	],
	"¶福井県":[
		"""\
		!
		img:	{{selected_image}},		hide
		var:	  selected_image,		🗻18福井県
		img:	{{selected_image}}
		choice:	1, 2, 3, 4, 5
		""",
		"""\
		　確定
		　石川県
		　岐阜県
		　滋賀県
		　京都府
		""",
	],
	"¶岐阜県":[
		"""\
		!
		img:	{{selected_image}},		hide
		var:	  selected_image,		🗻21岐阜県
		img:	{{selected_image}}
		choice:	1, 2, 3, 4, 5, 6, 7, 8
		""",
		"""\
		　確定
		　富山県
		　長野県
		　愛知県
		　三重県
		　滋賀県
		　福井県
		　石川県
		""",
	],
	"¶山梨県":[
		"""\
		!
		img:	{{selected_image}},		hide
		var:	  selected_image,		🗻19山梨県
		img:	{{selected_image}}
		choice:	1, 2, 3, 4, 5, 6
		""",
		"""\
		　確定
		　埼玉県
		　東京都
		　神奈川県
		　静岡県
		　長野県
		""",
	],
	"¶静岡県":[
		"""\
		!
		img:	{{selected_image}},		hide
		var:	  selected_image,		🗻22静岡県
		img:	{{selected_image}}
		choice:	1, 2, 3, 4, 5
		""",
		"""\
		　確定
		　山梨県
		　神奈川県
		　愛知県
		　長野県
		""",
	],
	"¶愛知県":[
		"""\
		!
		img:	{{selected_image}},		hide
		var:	  selected_image,		🗻23愛知県
		img:	{{selected_image}}
		choice:	1, 2, 3, 4, 5
		""",
		"""\
		　確定
		　岐阜県
		　長野県
		　静岡県
		　三重県
		""",
	],
	"¶滋賀県":[
		"""\
		!
		img:	{{selected_image}},		hide
		var:	  selected_image,		🗻25滋賀県
		img:	{{selected_image}}
		choice:	1, 2, 3, 4, 5
		""",
		"""\
		　確定
		　福井県
		　岐阜県
		　三重県
		　京都府
		""",
	],
	"¶京都府":[
		"""\
		!
		img:	{{selected_image}},		hide
		var:	  selected_image,		🗻26京都府
		img:	{{selected_image}}
		choice:	1, 2, 3, 4, 5, 6, 7
		""",
		"""\
		　確定
		　福井県
		　滋賀県
		　三重県
		　奈良県
		　大阪府
		　兵庫県
		""",
	],
	"¶兵庫県":[
		"""\
		!
		img:	{{selected_image}},		hide
		var:	  selected_image,		🗻28兵庫県
		img:	{{selected_image}}
		choice:	1, 2, 3, 4, 5, 6
		""",
		"""\
		　確定
		　京都府
		　大阪府
		　徳島県
		　岡山県
		　鳥取県
		""",
	],
	"¶三重県":[
		"""\
		!
		img:	{{selected_image}},		hide
		var:	  selected_image,		🗻24三重県
		img:	{{selected_image}}
		choice:	1, 2, 3, 4, 5, 6, 7
		""",
		"""\
		　確定
		　滋賀県
		　岐阜県
		　愛知県
		　和歌山県
		　奈良県
		　京都府
		""",
	],
	"¶奈良県":[
		"""\
		!
		img:	{{selected_image}},		hide
		var:	  selected_image,		🗻29奈良県
		img:	{{selected_image}}
		choice:	1, 2, 3, 4, 5
		""",
		"""\
		　確定
		　京都府
		　三重県
		　和歌山県
		　大阪府
		""",
	],
	"¶和歌山県":[
		"""\
		!
		img:	{{selected_image}},		hide
		var:	  selected_image,		🗻30和歌山県
		img:	{{selected_image}}
		choice:	1, 2, 3, 4
		""",
		"""\
		　確定
		　大阪府
		　奈良県
		　三重県
		""",
	],
	"¶大阪府":[
		"""\
		!
		img:	{{selected_image}},		hide
		var:	  selected_image,		🗻27大阪府
		img:	{{selected_image}}
		choice:	1, 2, 3, 4, 5
		""",
		"""\
		　確定
		　京都府
		　奈良県
		　和歌山県
		　兵庫県
		""",
	],
	"¶鳥取県":[
		"""\
		!
		img:	{{selected_image}},		hide
		var:	  selected_image,		🗻31鳥取県
		img:	{{selected_image}}
		choice:	1, 2, 3, 4, 5
		""",
		"""\
		　確定
		　兵庫県
		　岡山県
		　広島県
		　島根県
		""",
	],
	"¶島根県":[
		"""\
		!
		img:	{{selected_image}},		hide
		var:	  selected_image,		🗻32島根県
		img:	{{selected_image}}
		choice:	1, 2, 3, 4
		""",
		"""\
		　確定
		　鳥取県
		　広島県
		　山口県
		""",
	],
	"¶山口県":[
		"""\
		!
		img:	{{selected_image}},		hide
		var:	  selected_image,		🗻35山口県
		img:	{{selected_image}}
		choice:	1, 2, 3, 4
		""",
		"""\
		　確定
		　島根県
		　広島県
		　福岡県
		""",
	],
	"¶岡山県":[
		"""\
		!
		img:	{{selected_image}},		hide
		var:	  selected_image,		🗻33岡山県
		img:	{{selected_image}}
		choice:	1, 2, 3, 4, 5
		""",
		"""\
		　確定
		　鳥取県
		　兵庫県
		　香川県
		　広島県
		""",
	],
	"¶広島県":[
		"""\
		!
		img:	{{selected_image}},		hide
		var:	  selected_image,		🗻34広島県
		img:	{{selected_image}}
		choice:	1, 2, 3, 4, 5, 6
		""",
		"""\
		　確定
		　島根県
		　鳥取県
		　岡山県
		　愛媛県
		　山口県
		""",
	],
	"¶香川県":[
		"""\
		!
		img:	{{selected_image}},		hide
		var:	  selected_image,		🗻37香川県
		img:	{{selected_image}}
		choice:	1, 2, 3, 4
		""",
		"""\
		　確定
		　岡山県
		　徳島県
		　愛媛県
		""",
	],
	"¶徳島県":[
		"""\
		!
		img:	{{selected_image}},		hide
		var:	  selected_image,		🗻36徳島県
		img:	{{selected_image}}
		choice:	1, 2, 3, 4, 5
		""",
		"""\
		　確定
		　香川県
		　兵庫県
		　高知県
		　愛媛県
		""",
	],
	"¶愛媛県":[
		"""\
		!
		img:	{{selected_image}},		hide
		var:	  selected_image,		🗻38愛媛県
		img:	{{selected_image}}
		choice:	1, 2, 3, 4, 5
		""",
		"""\
		　確定
		　広島県
		　香川県
		　徳島県
		　高知県
		""",
	],
	"¶高知県":[
		"""\
		!
		img:	{{selected_image}},		hide
		var:	  selected_image,		🗻39高知県
		img:	{{selected_image}}
		choice:	1, 2, 3
		""",
		"""\
		　確定
		　徳島県
		　愛媛県
		""",
	],
	"¶福岡県":[
		"""\
		!
		img:	{{selected_image}},		hide
		var:	  selected_image,		🗻40福岡県
		img:	{{selected_image}}
		choice:	1, 2, 3, 4, 5
		""",
		"""\
		　確定
		　山口県
		　大分県
		　熊本県
		　佐賀県
		""",
	],
	"¶佐賀県":[
		"""\
		!
		img:	{{selected_image}},		hide
		var:	  selected_image,		🗻41佐賀県
		img:	{{selected_image}}
		choice:	1, 2, 3
		""",
		"""\
		　確定
		　福岡県
		　長崎県
		""",
	],
	"¶長崎県":[
		"""\
		!
		img:	{{selected_image}},		hide
		var:	  selected_image,		🗻42長崎県
		img:	{{selected_image}}
		choice:	1, 2
		""",
		"""\
		　確定
		　佐賀県
		""",
	],
	"¶大分県":[
		"""\
		!
		img:	{{selected_image}},		hide
		var:	  selected_image,		🗻44大分県
		img:	{{selected_image}}
		choice:	1, 2, 3, 4
		""",
		"""\
		　確定
		　宮崎県
		　熊本県
		　福岡県
		""",
	],
	"¶熊本県":[
		"""\
		!
		img:	{{selected_image}},		hide
		var:	  selected_image,		🗻43熊本県
		img:	{{selected_image}}
		choice:	1, 2, 3, 4, 5
		""",
		"""\
		　確定
		　福岡県
		　大分県
		　宮城県
		　鹿児島県
		""",
	],
	"¶宮崎県":[
		"""\
		!
		img:	{{selected_image}},		hide
		var:	  selected_image,		🗻45宮崎県
		img:	{{selected_image}}
		choice:	1, 2, 3, 4
		""",
		"""\
		　確定
		　大分県
		　鹿児島県
		　熊本県
		""",
	],
	"¶鹿児島県":[
		"""\
		!
		img:	{{selected_image}},		hide
		var:	  selected_image,		🗻46鹿児島県
		img:	{{selected_image}}
		choice:	1, 2, 3, 4
		""",
		"""\
		　確定
		　熊本県
		　宮崎県
		　沖縄県
		""",
	],
	"¶沖縄県":[
		"""\
		!
		img:	{{selected_image}},		hide
		var:	  selected_image,		🗻47沖縄県
		img:	{{selected_image}}
		choice:	1, 2
		""",
		"""\
		　確定
		　鹿児島県
		""",
	],
	"¶確定":[
		"""\
		きふわらべ
		「いったん　バトル部門に移動するぜ」
		""",
		# バトル部門へ飛ばします
		"""\
		!
		var:			battle_exit_department		,📗会話部門_🍉JapaneseRiver
		var:			battle_exit_section			,¶崎川市最強振興会館
		department:		📗バトル部門_🍉Battle			,%ignorable%
		goto:			¶１回目戦闘シーン
		""",
		# バトル部門がなければ、直後の goto 文は１回無視され、以下へフォールスルー
		"""\
		＊
		「戦闘シーンは省略しまーす
		""",
		"""\
		!
		img:		🐕ヘム将棋, hide
		img:		🗻ツツジロード, hide
		goto:		¶崎川市最強振興会館
		"""
	],
	"¶崎川市最強振興会館":[
		"""\
		!
		bg_music:
		img:		🗻４Ｆイベントルーム
		""",
		# ２３４５６７８９０１２３４５６７８９０
		"""\
		お父ん
		「おはようございまーす
		""",
		"""\
		ひよ子
		「席はまだ決まってないから
		　好きなところに座りましょう
		""",
		"""\
		きふわらべ
		「お父ん、知ってたら教えてくれだぜ。
		　エスフェン(SFEN)の 7g7f って何だぜ？
		""",
		"""\
		お父ん
		「あー。７筋の７段目の駒を６段目に
		　突くことだぜ。分かったら　もう寝ろ
		""",
		# 将棋盤を表示
		"""\
		!
		img:	🎴中央ウィンドウ
		img:	🎴将棋盤
		""",
		# ２３４５６７８９０１２３４５６７８９０
		"""\
		ひよ子
		「横着しないで　ちゃんと　将棋盤を使って
		　説明しなさい
		""",
		"""\
		!
		img:	🎴将棋盤	, hide
		img:	🎴ファイルとランク
		""",
		"""\
		お父ん
		「右上が始まりで、左へ１筋、２筋・・・
		　下へａ段、ｂ段・・・　だぜ
		""",
		"""\
		!
		img:	🎴ファイルとランク, hide
		img:	🎴将棋盤
		""",
		"""\
		きふわらべ
		「3c3d　って何だぜ？
		""",
		"""\
		お父ん
		「角換わりだろ。
		　もう寝ろ
		""",
		# 音楽鳴らす
		"""\
		!
		bg_music: 🎵きふわらべファイター２
		""",
		"""\
		きふわらべ
		「お父ん、なんで唐揚げを食べてるんだぜ？
		　ダイエットはどうした？野菜食べろだぜ！
		""",
		# 中央ビューイング・ウィンドウを非表示
		"""\
		!
		img:	🎴中央ウィンドウ, hide
		img:	🎴将棋盤, hide
		""",
		"""\
		お父ん
		「元気になりたくて唐揚げを食べるんだぜ
		""",
		# ２３４５６７８９０１２３４５６７８９０
		"""\
		　カロリー計算しようと思ったときもあった
		　上限いっぱいまで食べてしまうので止めた
		""",
		"""\
		ひよ子
		「カロリーを　炭水化物、糖質、脂質で
		　補うのを止めなさい
		""",
		# 無音にする
		"""\
		!
		bg_music:
		""",
		"""\
		ひよ子
		「ワラちゃん。 6g6f よ
		""",
		"""\
		きふわらべ
		「ろく　じー　ろく　えふ？
		　それは……
		""",
		# ２３４５６７８９０１２３４５６７８９０
		"""\
		!
		choice: 1,2
		""",
		"""\
		　・６筋の７段目の駒を６段目に突く
		　・角道を止める
		""",
	],
	"¶６筋の７段目の駒を６段目に突く":[
		"""\
		お父ん
		「覚えたか
		""",
		"""\
		きふわらべ
		「お父んも覚えろだぜ
		""",
		"""\
		!
		goto: ¶エンディング
		"""
	],
	"¶角道を止める":[
		"""\
		お父ん
		「難しいこと知ってんな
		""",
		"""\
		きふわらべ
		「矢倉も作れるしな
		""",
		"""\
		!
		goto: ¶エンディング
		"""
	],
	"¶エンディング":[
		# ２３４５６７８９０１２３４５６７８９０
		"""\
		お父ん
		「は～　腹が減ったなあ
		　昼は何を食べようかなあ
		""",
		"""\
		きふわらべ
		「コンビニのグリルチキンを食べろだぜ
		""",
		"""\
		!
		bg_music:	🎵エンディング
		img:	🗻エンディング
		telop:	Ｔエンディング
		"""
	],
}
