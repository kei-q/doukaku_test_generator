
doukaku_test_generator
========

これはオフラインリアルタイムどう書く用のテストデータを返すwebサービスです。
いろいろやっつけで作っているので、仕様は変わる可能性が高いです。

サンプル
--------

http://keqh.net/doukaku/q12/haskell
上記リクエストするとテストデータのテンプレっぽいのが返ってきます。

使い方
--------

http://keqh.net/doukaku/{{問題ID}}/{{テンプレ名}}

問題ID: testdata以下のfile名(.txt抜きで)
テンプレ名: template以下のfile名(.tpl抜きで)

うまくいけば200、なければ404を返します。

templateの増やし方
--------

template/haskell_hspec.tplなどを参考にテンプレ書いてpull reqお願いします。

testdataの増やし方
--------

testdata/q12.txtなどを参考にデータを書いてpull reqお願いします。
