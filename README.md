hisho-query
===========
Sass3.3 and compass1.0 Library  

sass3.3(RC)とcompassで動作する、sass function Library  

バージョン
------
0.1.1

開発環境
------
Sass 3.3.0.rc.2  
compass 1.0.0.alpha.17  


利用方法
------

[1]sassフォルダ内に"hisho-query"フォルダを作成  

[2]上記にファイルを配置  

	/sass/hisho-query/_hquery-0.1.scss
	/sass/hisho-query/_hquery-function-0.1.rb

[3]compassの"config.rb"内に追記  

	require "./sass/hisho-query/_hquery-function-0.1.rb"

[4]sass内でinclude  

	@import "hisho-query/_hquery-0.1";


hq functionの使い方
------

各typeを処理する為のmethodを用意。  
第一引数にmethod名、第二引数は変換するデータ、第三引数以降はmethodで使う引数を指定  

	$hoge: hq("map.get", $map, $argument);

jqueryで使われている"method chain"のように一括で処理する為に、  
「method query」「method map」と言うインターフェイスを用意。  

=今までは  

	$hoge: hq("str.quote", hq("map.get", $map)　);

=method query  

	//指定したmethodを順番に処理し結果を返す
	$hoge: hq("map.get->str.quote", $map);
	
	//引数は第三引数以降に順番に設定していく
	$hoge: hq("str.split->list.get->str.insert->str.quote", $str, ".", 1, "hoge", 3);

=method map  

	hoge: hq($str, (
		"str.split" : "." ,
		"list.get"  : 1,
		"str.insert" : "hoge" 3,
		"str.quote" : null
	));


method list (ざっくり)
------

下記を記載しcompassでコンパイルすると、利用できるmethod一覧がプロンプト（ターミナル）に表示される。  
methodの役割はmethod名から判断してくださいw  

-scss  

	$hoge: hq("help");
	$hoge: hq("str.help");
	$hoge: hq("num.help");
	$hoge: hq("list.help");
	$hoge: hq("map.help");
	$hoge: hq("is.help");
	$hoge: hq("css.help");

-プロンプト（ターミナル）  

	-------------------------------------------------------
	| method        | query | return |deep| 説明
	-------------------------------------------------------
	| map.get       | true  |  other | o  | keyを指定し値を取得
	| map.set       | true  |   map  | o  | 指定したkeyに値を代入
	| map.extend    | false |   map  | o  | mapとmapをマージ(複数指定,deeq指定可能)
	| map.merge     | true  |   map  | x  | mapとmapをマージ
	| map.mergeDeep | true  |   map  | o  | mapとmapをDeepマージ
	-------------------------------------------------------
	$h: hq( "map.get", $mapd, "cat.colorType" );          -> black
	$h: hq( "map.keys", $map );                -> hoge, fuga
	$h: hq( "map.values", $map );              -> 2, e
	$h: hq( "map.hasKey", $map, "hoge" );      -> true
	$h: hq( "map.nth", $map, 2 );              -> e
	$h: hq( "map.length", $mapd);              -> 2
	-------------------------------------------------------


あと下記のfunctionで、指定した変数の値の型がプロンプト（ターミナル）に表示される。  
@debugで表示していた、行番号を削除し型を表示するcustomDebug  

-scss  

	$hoge: hq-debug($value);

-プロンプト（ターミナル）  

	
	Sass::Script::Value::String : "hogehogehoge"
	


今後
------
* 2日で適当に作ったので、コードが冗長化してる。どこかのタイミングでリファクタリングする
* color系のfunctionはめんどくさいので、要望ない限り実装しない。
* v0.3辺りでパフォーマンス対応検討







