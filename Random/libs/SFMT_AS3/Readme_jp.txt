Readme_jp.txt

====================

SFMT 簡易版クラス
author:kimura@sionnet.jp

パッケージ:

jp.sionnet.utils.Sfmt

====================

概要:
要約すれば、高度な擬似乱数を発生するメルセンヌ・ツイスタの高速版がSFMTです。
このSFMTの各言語版を公開されているisakuさんの簡易版ライブラリをActionScript3.0に移植したものです。
内容はちっとも理解できてないので、間違いがあったらご指摘いただけると幸いです。

SFMT:
http://www.math.sci.hiroshima-u.ac.jp/~m-mat/MT/SFMT/index-jp.html

乱数ライブラリ:
http://www001.upp.so-net.ne.jp/isaku/rand2.html


ライセンス:
SFMTのライセンスに依ります。2009年2月現在、修正BSDライセンスです。

====================

使い方:
クラスパスに追加してimportしてください。
コンストラクタへは整数のシードを与えます。同じシードなら予測可能な値を返します。
別な値を返すインスタンスを作成する場合は違うシードを与えてください。

例:
mySfmt1 = new Sfmt(1);
mySfmt2 = new Sfmt(2);//この2つのインスタンスは別な値を返す

提供するメソッド:
移植元の簡易版と同じメソッドを持ちます。

nextMt()        32ビット符号なし整数の乱数:int
nextUnif()      0 以上 1 未満の乱数(53ビット精度):Number
nextInt(N)      0 以上 N 未満の整数乱数:int


例:SfmtTest.as
~~~~~~~~~~~~~~~~~~~~~~~~
package
{
	import flash.display.Sprite;
	import jp.sionnet.utils.Sfmt;
	
	/**
	 * SFMT乱数のテスト
	 */
	public class SfmtTest extends Sprite
	{
		public var mySfmt:Sfmt;
		
		public function SfmtTest() 
		{
			mySfmt = new Sfmt(1);//シード1で初期化
			sfmtTracer(100);//100個の乱数をtrace
		}
		
		private function sfmtTracer(n:uint):void
		{
			for (var i:uint = 0; i < n; i++)
			{
				trace(mySfmt.nextInt(100));//0以上100未満の整数乱数を表示
			}
		}
		
	}
	
}
~~~~~~~~~~~~~~~~~~~~~~~~
