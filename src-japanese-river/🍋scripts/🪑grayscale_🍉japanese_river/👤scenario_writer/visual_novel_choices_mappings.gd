# チョイスズ・マッピングス（Choices Mappings；選択肢の紐づけ）
extends Node


# 選択肢と飛び先
#
# 	- この `choices_mappings` という変数名は変えないでください
#	- ファイル名は変えても構いません
#	- `📗～部門` ノードにぶら下がっているファイルを読みに行きます
#
var choices_mappings = {

	# このキーは［段落名］と呼ぶことにします
	#
	#	- 頭に「¶」を付けているのは見やすさのためで、付けなくても構いません
	#	- `📗～部門` ノードにぶら下がっている他のファイルの `choices_mappings` のセクション名と被らないように運用してください
	#
	&"¶タイトル画面" : {
		# 選択肢の行番号と、移動先の［セクション名］
		1 : &"¶はじまり",
		2 : &"¶終了",
	},
	&"¶北海道" : {
		# ボタン押下
		&"VK_Ok" : &"¶確定",
		&"VK_Down" : {
			# レバーは + - も指定
			&"+" : &"¶青森県",
		},
	},
	&"¶青森県" : {
		&"VK_Ok" : &"¶確定",
		# ナナメ入力は、 &"VK_Down" の中に &"VK_Right" を入れる順番にしてください
		&"VK_Down" : {
			&"-" : &"¶北海道",
			&"+" : {
				# ナナメ入力があるときに、ナナメ入力でない上下方向があるなら、バーチャル・キー名を空文字列にしてください
				&"" : &"¶秋田県",
				&"VK_Right" : {
					&"+" : &"¶岩手県",
				},
			},
		},
	},
	&"¶秋田県" : {
		&"VK_Ok" : &"¶確定",
		&"VK_Right" : {
			&"+" : &"¶岩手県",
		},
		&"VK_Down" : {
			&"-" : &"¶青森県",
			&"+" : {
				&"" : &"¶山形県",
				&"VK_Right" : {
					&"+" : &"¶宮城県",
				},
			},
		},
	},
	&"¶岩手県" : {
		&"VK_Ok" : &"¶確定",
		&"VK_Right" : {
			&"-" : &"¶秋田県",
		},
		&"VK_Down" : {
			&"-" : &"¶青森県",
			&"+" : &"¶宮城県",
		},
	},
	&"¶山形県" : {
		&"VK_Ok" : &"¶確定",
		&"VK_Right" : {
			&"-" : &"¶新潟県",
			&"+" : &"¶宮城県",
		},
		&"VK_Down" : {
			&"-" : &"¶秋田県",
			&"+" : &"¶福島県",
		},
	},
	&"¶宮城県" : {
		&"VK_Ok" : &"¶確定",
		&"VK_Right" : {
			&"-" : &"¶山形県",
		},
		&"VK_Down" : {
			&"-" : {
				&"" : &"¶岩手県",
				&"VK_Right" : {
					&"-" : &"¶秋田県",
				},
				
			},
			&"+" : &"¶福島県",
		},
	},
	&"¶福島県" : {
		&"VK_Ok" : &"¶確定",
		&"VK_Right" : {
			&"-" : &"¶新潟県",
		},
		&"VK_Down" : {
			&"-" : {
				&"" : &"¶山形県",
				&"VK_Right" : {
					&"+" : &"¶宮城県",
				},
			},
			&"+" : {
				&"" : &"¶栃木県",
				&"VK_Right" : {
					&"-" : &"¶群馬県",
					&"+" : &"¶茨城県",
				},
			},
		},
	},
	&"¶群馬県" : {
		&"VK_Ok" : &"¶確定",
		&"VK_Right" : {
			&"-" : &"¶長野県",	
			&"+" : &"¶栃木県",
		},
		&"VK_Down" : {
			&"-" : {
				&"" : &"¶新潟県",
				&"VK_Right" : {
					&"-" : &"¶福島県",
				},
			},
			&"+" : &"¶埼玉県",
		},
	},
	&"¶栃木県" : {
		&"VK_Ok" : &"¶確定",
		&"VK_Right" : {
			&"-" : &"¶群馬県",
			&"+" : &"¶茨城県",
		},
		&"VK_Down" : {
			&"-" : &"¶福島県",
			&"+" : &"¶埼玉県",
		},
	},
	&"¶茨城県" : {
		&"VK_Ok" : &"¶確定",
		&"VK_Right" : {
			&"-" : &"¶栃木県",
		},
		&"VK_Down" : {
			&"-" : &"¶福島県",
			&"+" : {
				&"" : &"¶千葉県",
				&"VK_Right" : {
					&"-" : &"¶埼玉県",
				},
			},
		},
	},
	&"¶千葉県" : {
		&"VK_Ok" : &"¶確定",
		&"VK_Right" : {
			&"-" : &"¶東京都",
		},
		&"VK_Down" : {
			&"-" : {
				&"" : &"¶茨城県",
				&"VK_Right" : {
					&"-" : &"¶埼玉県",
				},
			},
			&"+" : {
				&"VK_Right" : {
					&"-" : &"¶神奈川県",
				},
			},
		},
	},
	&"¶埼玉県" : {
		&"VK_Ok" : &"¶確定",
		&"VK_Right" : {
			&"-" : &"¶長野県",	
			&"+" : &"¶茨城県",
		},
		&"VK_Down" : {
			&"-" : {
				&"" : &"¶群馬県",
				&"VK_Right" : {
					&"+" : &"¶栃木県",
				},
			},
			&"+" : {
				&"" : &"¶東京都",
				&"VK_Right" : {
					&"-" : &"¶山梨県",
					&"+" : &"¶千葉県",
				},
			},
		},
	},
	&"¶東京都" : {
		&"VK_Ok" : &"¶確定",
		&"VK_Right" : {
			&"-" : &"¶山梨県",
			&"+" : &"¶千葉県",
		},
		&"VK_Down" : {
			&"-" : &"¶埼玉県",
			&"+" : &"¶神奈川県",
		},
	},
	&"¶神奈川県" : {
		&"VK_Ok" : &"¶確定",
		&"VK_Right" : {
			&"-" : &"¶山梨県",
			&"+" : &"¶千葉県",
		},
		&"VK_Down" : {
			&"-" : &"¶東京都",
			&"+" : {
				&"VK_Right" : {
					&"-" : &"¶静岡県",
				},
			},
		},
	},
	&"¶新潟県" : {
		&"VK_Ok" : &"¶確定",
		&"VK_Right" : {
			&"-" : &"¶富山県",
			&"+" : &"¶福島県",
		},
		&"VK_Down" : {
			&"-" : {
				&"VK_Right" : {
					&"+" : &"¶山形県",
				},
			},
			&"+" : {
				&"" : &"¶群馬県",
				&"VK_Right" : {
					&"-" : &"¶長野県",
				},
			},
		},
	},
	&"¶長野県" : {
		&"VK_Ok" : &"¶確定",
		&"VK_Right" : {
			&"-" : &"¶岐阜県",
			&"+" : &"¶埼玉県",
		},
		&"VK_Down" : {
			&"-" : {
				&"" : &"¶新潟県",
				&"VK_Right" : {
					&"-" : &"¶富山県",
					&"+" : &"¶群馬県",
				},
			},
			&"+" : {
				&"" : &"¶静岡県",
				&"VK_Right" : {
					&"-" : &"¶愛知県",
					&"+" : &"¶山梨県",
				},
			},
		},
	},
	&"¶富山県" : {
		&"VK_Ok" : &"¶確定",
		&"VK_Right" : {
			&"-" : &"¶石川県",
			&"+" : &"¶新潟県",	# 右、右上
		},
		&"VK_Down" : {
			&"-" : {
				&"VK_Right" : {
					&"+" : &"¶新潟県",	# 右、右上
				},
			},
			&"+" : {
				&"" : &"¶岐阜県",	# 下
				&"VK_Right" : {
					&"+" : &"¶長野県",	# 右下
				},
			},
		},
	},
	&"¶石川県" : {
		&"VK_Ok" : &"¶確定",
		&"VK_Right" : {
			&"-" : &"¶福井県",		# 左、下、左下
			&"+" : &"¶富山県",
		},
		&"VK_Down" : {
			&"+" : {
				&"" : &"¶福井県",		# 左、下、左下
				&"VK_Right" : {
					&"-" : &"¶福井県",	# 左、下、左下
					&"+" : &"¶岐阜県",
				},
			},
		},
	},
	&"¶福井県" : {
		&"VK_Ok" : &"¶確定",
		&"VK_Right" : {
			&"-" : &"¶京都府",
			&"+" : &"¶岐阜県",
		},
		&"VK_Down" : {
			&"-" : &"¶石川県",
			&"+" : &"¶滋賀県",
		},
	},
	&"¶岐阜県" : {
		&"VK_Ok" : &"¶確定",
		&"VK_Right" : {
			&"-" : &"¶福井県",
			&"+" : &"¶長野県",
		},
		&"VK_Down" : {
			&"-" : {
				&"" : &"¶富山県",
				&"VK_Right" : {
					&"-" : &"¶石川県",
				},
			},
			&"+" : {
				&"" : &"¶三重県",
				&"VK_Right" : {
					&"-" : &"¶滋賀県",
					&"+" : &"¶愛知県",
				},
			},
		},
	},
	&"¶山梨県" : {
		&"VK_Ok" : &"¶確定",
		&"VK_Right" : {
			&"-" : &"¶長野県", # 左、上、左上
			&"+" : &"¶東京都",
		},
		&"VK_Down" : {
			&"-" : {
				&"" : &"¶長野県", # 左、上、左上
				&"VK_Right" : {
					&"-" : &"¶長野県", # 左、上、左上
					&"+" : &"¶埼玉県",
				},
			},
			&"+" : {
				&"" : &"¶静岡県",
				&"VK_Right" : {
					&"+" : &"¶神奈川県",
				},
			},
		},
	},
	&"¶静岡県" : {
		&"VK_Ok" : &"¶確定",
		&"VK_Right" : {
			&"-" : &"¶愛知県",
			&"+" : &"¶神奈川県", # 右、右上
		},
		&"VK_Down" : {
			&"-" : {
				&"" : &"¶山梨県",
				&"VK_Right" : {
					&"-" : &"¶長野県",
					&"+" : &"¶神奈川県", # 右、右上
				},
			},
		},
	},
	&"¶愛知県" : {
		&"VK_Ok" : &"¶確定",
		&"VK_Right" : {
			&"-" : &"¶三重県",
			&"+" : &"¶静岡県",
		},
		&"VK_Down" : {
			&"-":{
				&"" : &"¶岐阜県",
				&"VK_Right" : {
					&"+" : &"¶長野県",
				},
			}
		},
	},
	&"¶滋賀県" : {
		&"VK_Ok" : &"¶確定",
		&"VK_Right" : {
			&"-" : &"¶京都府",
			&"+" : &"¶岐阜県",
		},
		&"VK_Down" : {
			&"-" : &"¶福井県",
			&"+" : &"¶三重県",
		},
	},
	&"¶京都府" : {
		&"VK_Ok" : &"¶確定",
		&"VK_Right" : {
			&"-" : &"¶兵庫県",
			&"+" : &"¶滋賀県",
		},
		&"VK_Down" : {
			&"-" : {
				&"VK_Right" : {
					&"+" : &"¶福井県",
				},
			},
			&"+" : {
				&"" : &"¶奈良県",
				&"VK_Right" : {
					&"-" : &"¶大阪府",
					&"+" : &"¶三重県",
				},
			},
		},
	},
	&"¶兵庫県" : {
		&"VK_Ok" : &"¶確定",
		&"VK_Right" : {
			&"-" : &"¶岡山県",	# 左、左下
			&"+" : &"¶京都府",	# 右、右下
		},
		&"VK_Down" : {
			&"-" : {
				&"VK_Right" : {
					&"-" : &"¶鳥取県",
					&"+" : &"¶京都府",
				},
			},
			&"+" : {
				&"" : &"¶徳島県",
				&"VK_Right" : {
					&"-" : &"¶岡山県",	# 左、左下
					&"+" : &"¶大阪府",
				},
			},
		},
	},
	&"¶三重県" : {
		&"VK_Ok" : &"¶確定",
		&"VK_Right" : {
			&"-" : &"¶奈良県",
			&"+" : &"¶愛知県",
		},
		&"VK_Down" : {
			&"-" : {
				&"" : &"¶滋賀県",
				&"VK_Right" : {
					&"-" : &"¶京都府",
					&"+" : &"¶岐阜県",
				},
			},
			&"+" : {
				&"VK_Right" : {
					&"-" : &"¶和歌山県",
				},
			},
		},
	},
	&"¶奈良県" : {
		&"VK_Ok" : &"¶確定",
		&"VK_Right" : {
			&"-" : &"¶大阪府",
			&"+" : &"¶三重県",
		},
		&"VK_Down" : {
			&"-" : &"¶京都府",
			&"+" : {
				&"" : &"¶和歌山県",	# 下、左下
				&"VK_Right" : {
					&"-" : &"¶和歌山県",		# 下、左下
				},
			},
		},
	},
	&"¶和歌山県" : {
		&"VK_Ok" : &"¶確定",
		&"VK_Right" : {
			&"+" : &"¶三重県",
		},
		&"VK_Down" : {
			&"-" : {
				&"" : &"¶大阪府",
			},
			&"VK_Right" : {
				&"+" : &"¶奈良県",
			},
		},
	},
	&"¶大阪府" : {
		&"VK_Ok" : &"¶確定",
		&"VK_Right" : {
			&"+" : &"¶奈良県",
		},
		&"VK_Down" : {
			&"-" : {
				&"" : &"¶京都府",
				&"VK_Right" : {
					&"-" : &"¶兵庫県",
				},
			},
			&"+" : &"¶和歌山県",
		},
	},
	&"¶鳥取県" : {
		&"VK_Ok" : &"¶確定",
		&"VK_Right" : {
			&"-" : &"¶島根県",
			&"+" : &"¶兵庫県",
		},
		&"VK_Down" : {
			&"+" : {
				&"" : &"¶岡山県",
				&"VK_Right" : {
					&"-" : &"¶広島県",
				},
			},
		},
	},
	&"¶島根県" : {
		&"VK_Ok" : &"¶確定",
		&"VK_Right" : {
			&"-" : &"¶山口県",
			&"+" : &"¶鳥取県",
		},
		&"VK_Down" : {
			&"+" : &"¶広島県",
		},
	},
	&"¶山口県" : {
		&"VK_Ok" : &"¶確定",
		&"VK_Right" : {
			&"-" : &"¶福岡県",	# 左、下、左下
			&"+" : &"¶広島県",
		},
		&"VK_Down" : {
			&"-" : {
				&"VK_Right" : {
					&"+" : &"¶島根県",
				},
			},
			&"+" : {
				&"" : &"¶福岡県",	# 左、下、左下
				&"VK_Right" : {
					&"-" : &"¶福岡県",	# 左、下、左下
				},
			},
		},
	},
	&"¶岡山県" : {
		&"VK_Ok" : &"¶確定",
		&"VK_Right" : {
			&"-" : &"¶広島県",
			&"+" : &"¶兵庫県",
		},
		&"VK_Down" : {
			&"-" : &"¶鳥取県",
			&"+" : &"¶香川県",
		},
	},
	&"¶広島県" : {
		&"VK_Ok" : &"¶確定",
		&"VK_Right" : {
			&"-" : &"¶山口県",
			&"+" : &"¶岡山県",
		},
		&"VK_Down" : {
			&"-" : {
				&"" : &"¶島根県",
				&"VK_Right" : {
					&"+" : &"¶鳥取県",
				},
			},
			&"+" : &"¶愛媛県",
		},
	},
	&"¶香川県" : {
		&"VK_Ok" : &"¶確定",
		&"VK_Right" : {
			&"-" : &"¶愛媛県",
		},
		&"VK_Down" : {
			&"-" : &"¶岡山県",
			&"+" : &"¶徳島県",
		},
	},
	&"¶徳島県" : {
		&"VK_Ok" : &"¶確定",
		&"VK_Right" : {
			&"-" : &"¶愛媛県",
			&"+" : &"¶兵庫県",	# 右、右上
		},
		&"VK_Down" : {
			&"-" : {
				&"" : &"¶香川県",
				&"VK_Right" : {
					&"+" : &"¶兵庫県",	# 右、右上
				},
			},
			&"+" : &"¶高知県",
		},
	},
	&"¶愛媛県" : {
		&"VK_Ok" : &"¶確定",
		&"VK_Right" : {
			&"+" : &"¶徳島県",
		},
		&"VK_Down" : {
			&"-" : {
				&"" : &"¶広島県",
				&"VK_Right" : {
					&"+" : &"¶香川県",
				},
			},
			&"+" : &"¶高知県",
		},
	},
	&"¶高知県" : {
		&"VK_Ok" : &"¶確定",
		&"VK_Right" : {
			&"-" : &"¶愛媛県",	# 左、上、左上
			&"+" : &"¶徳島県",	# 右、右上
		},
		&"VK_Down" : {
			&"-" : {
				&"" : &"¶愛媛県",		# 左、上、左上
				&"VK_Right" : {
					&"-" : &"¶愛媛県",	# 左、上、左上
					&"+" : &"¶徳島県",
				},
			},
			&"+" : &"¶高知県",
		},
	},
	&"¶福岡県" : {
		&"VK_Ok" : &"¶確定",
		&"VK_Right" : {
			&"-" : &"¶佐賀県",
			&"+" : &"¶大分県",
		},
		&"VK_Down" : {
			&"-" : &"¶山口県",
			&"+" : &"¶熊本県",
		},
	},
	&"¶佐賀県" : {
		&"VK_Ok" : &"¶確定",
		&"VK_Right" : {
			&"-" : &"¶長崎県",	# 左、下、左下
			&"+" : &"¶福岡県",	# 右、上、右上
		},
		&"VK_Down" : {
			&"-" : {
				&"" : &"¶福岡県",		# 右、上、右上
				&"VK_Right" : {
					&"+" : &"¶福岡県",	# 右、上、右上
				},
			},
			&"+" : {
				&"" : &"¶長崎県",		# 左、下、左下
				&"VK_Right" : {
					&"-" : &"¶長崎県",	# 左、下、左下
				},
			},
		},
	},
	&"¶長崎県" : {
		&"VK_Ok" : &"¶確定",
		&"VK_Right" : {
			&"+" : &"¶佐賀県",	# 右、下、右下
		},
		&"VK_Down" : {
			&"-" : {
				&"" : &"¶佐賀県",		# 右、下、右下
				&"VK_Right" : {
					&"+" : &"¶佐賀県",	# 右、下、右下
				},
			},
		},
	},
	&"¶大分県" : {
		&"VK_Ok" : &"¶確定",
		&"VK_Right" : {
			&"-" : &"¶福岡県",	# 左、上、左上
		},
		&"VK_Down" : {
			&"-" : {
				&"" : &"¶福岡県",		# 左、上、左上
				&"VK_Right" : {
					&"-" : &"¶福岡県",	# 左、上、左上
				},
			},
			&"+" : {
				&"" : &"¶宮崎県",
				&"VK_Right" : {
					&"-" : &"¶熊本県",
				},
			},
		},
	},
	&"¶熊本県" : {
		&"VK_Ok" : &"¶確定",
		&"VK_Right" : {
			&"+" : &"¶宮崎県",
		},
		&"VK_Down" : {
			&"-" : {
				&"" : &"¶福岡県",
				&"VK_Right" : {
					&"+" : &"¶大分県",
				},
			},
			&"+" : &"¶鹿児島県",
		},
	},
	&"¶宮崎県" : {
		&"VK_Ok" : &"¶確定",
		&"VK_Right" : {
			&"-" : &"¶熊本県",
		},
		&"VK_Down" : {
			&"-" : &"¶大分県",
			&"+" : &"¶鹿児島県",
		},
	},
	&"¶鹿児島県" : {
		&"VK_Ok" : &"¶確定",
		&"VK_Right" : {
			&"-" : &"¶沖縄県",	# 左、下、左下
			&"+" : &"¶宮崎県",	# 右、右上
		},
		&"VK_Down" : {
			&"-" : {
				&"" : &"¶熊本県",
				&"VK_Right" : {
					&"+" : &"¶宮崎県",	# 右、右上
				},
			},
			&"+" : {
				&"" : &"¶沖縄県",		# 左、下、左下
				&"VK_Right" : {
					&"-" : &"¶沖縄県",	# 左、下、左下
				},
			},
		},
	},
	&"¶沖縄県" : {
		&"VK_Ok" : &"¶確定",
		&"VK_Right" : {
			&"+" : &"¶鹿児島県",		# 右、上、右上
		},
		&"VK_Down" : {
			&"-" : {
				&"" : &"¶鹿児島県",		# 右、上、右上
				&"VK_Right" : {
					&"+" : &"¶鹿児島県",		# 右、上、右上
				},
			},
		},
	},
	&"¶崎川市最強振興会館" : {
		1 : &"¶６筋の７段目の駒を６段目に突く",
		2 : &"¶角道を止める",
	},
}
