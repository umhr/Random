/*
SFMTを含んでいるため、修正BSDライセンスです。
SFMTについては、260行目あたりを参照。

本当は↓からforkにしたかったけど、
http://wonderfl.kayac.com/code/feb94dc51f5dfdeb1aeef3d16b35c70661e6b963
ライセンス的にダメだったので方向転換。


◆Math.random()と線形合同法とSFMTの三つを
を比較してみた。

それぞれを実行時間(sec)を計るために100万回実行し、
また、取り出した値の偏りを視覚的に確認するために、
40万の点の座標をx,yで作り、画像に埋めていった。
計算結果に偏りがある場合はムラやパターン、筋が現れるはず。


結果
MacOSX10.5.7/2.4GHzCore2Duo、FlashPlayer10,0,22,87では
0.587sec：Math.random
0.037sec：線形合同法
0.515sec：SFMT
確認画像では、三つともほぼ同じ程度のムラとなった。


結論
これくらいのムラは実用上問題ない。

・Math.randomについて
特に偏りがひどいとかは無いような。

・線形合同法について
randomSeedを与えられる、計算が速いという理由で
今回作った線形合同法が良いかも。

・SFMTについて
SFMTは今回くらいのテスト内容だと、
特にメリットが見いだせなかった。
それとも実装の問題なのだろうか、、、。


＝＝＝＝＝

最近、アルゴリズムの本を読んで気になっていたので、
random()を調べてみた。

コンピュータでは通常、完全にランダムな
値を作ることはできない。
実用上問題無いくらいにバラバラの値を
上手い計算方法で取り出して使っている。
これを疑似乱数（pseudo-random number）
という。

疑似乱数の計算方法はいくつも提案されているが、
その中でも特に使われているのは、
線形合同法のようだ。
ActionScript3.0のMath.random()も
線形合同法かもしれない。

ただし、線形合同法は設定値の組み合わせによって、
振る舞いが変わる。言語によってバラバラなので、
結果、良い線形合同法と悪い線形合同法が
できてしまっている。注意が必要だ。

また、疑似乱数では再現可能なしくみ、
乱数の種（randomSeed）を与えることができる。
疑似乱数はあくまでも計算結果なため、
初期値が同じなら、同じ結果が得られるためだ。

例えば疑似乱数を使っての動作チェック時に、
「同じ組み合わせの疑似乱数で再テストをしたい」
ということはよくある。
この場合、randomSeedをメモしておいて、
再テスト時には、このrandomSeedを再び与えれば良い。

ASでは疑似乱数の生成方法が公開されておらず、
Math.random()にrandomSeedを与えることもできない。


注：
元のbitmapDataの色は0x000000であり、
計算結果により座標が得られると、そこの点が若干明るくなる。
次に同じ座標が得られた場合は、さらに明るくなる。
0x00から始まり、0xFFまで青が段々強くなっていく。
最終段階は目立ちやすいように赤0xFF0000にした。


SFMTについては、260行目あたりを参照。

参考
http://www.eqliquid.com/blog/2009/02/sfmt-actionscript-30.html
http://www001.upp.so-net.ne.jp/isaku/rand.html
http://hp.vector.co.jp/authors/VA004808/random1.html
http://d.hatena.ne.jp/keyword/%C0%FE%B7%C1%B9%E7%C6%B1%CB%A1
*/
package {
	import flash.display.Sprite;
	import flash.text.TextField;
	public class Main extends Sprite {
		public var mySfmt:Sfmt = new Sfmt(1);
		public var my00DrawBitmap:DrawBitmap = new DrawBitmap(this,0,0);
		public var my01DrawBitmap:DrawBitmap = new DrawBitmap(this,0,1);
		public var my02DrawBitmap:DrawBitmap = new DrawBitmap(this,0,2);
		public function Main():void {
			var time:Number = new Date().getTime();
			benchMarkj(_a0);
			benchMarkj(_a1);
			benchMarkj(_a2);
			benchMarkj(_a99);
			my00DrawBitmap.txt(""+benchMarkj(_a0)/1000+"sec：Math.random");
			benchDraw(_b0);
			my01DrawBitmap.txt(""+benchMarkj(_a1)/1000+"sec：線形合同法");
			benchDraw(_b1);
			my02DrawBitmap.txt(""+benchMarkj(_a2)/1000+"sec：SFMT");
			benchDraw(_b2);
		}

		//100万回関数を実行して、かかった時間を計っている。
		private function benchMarkj(_fn:Function):int {
			var time:Number = (new Date()).getTime();
			_fn(1000000);
			return (new Date()).getTime() - time;
		}
		
		//40万回関数を実行して、ビットマップの色を変える。
		private function benchDraw(_fn:Function):void {
			_fn(400000);
		}

		private function _a0(n:uint):void {
			for (var i:int = 0; i < n; i++) {
				Math.random();
			}
		}

		private function _a1(n:uint):void {
			for (var i:int = 0; i < n; i++) {
				Mas.random();
			}
		}

		private function _a2(n:uint):void {
			for (var i:int = 0; i < n; i++) {
				mySfmt.random();
			}
		}
		private function _b0(n:uint):void {
			for (var i:int = 0; i < n; i++) {
				my00DrawBitmap.pxy(Math.random(),Math.random());
			}
		}

		private function _b1(n:uint):void {
			for (var i:int = 0; i < n; i++) {
				my01DrawBitmap.pxy(Mas.random(),Mas.random());
			}
		}

		private function _b2(n:uint):void {
			for (var i:int = 0; i < n; i++) {
				my02DrawBitmap.pxy(mySfmt.random(),mySfmt.random());
			}
		}

		private function _a99(n:uint):void {
			for (var i:int = 0; i < n; i++) {
				zero();
			}
		}
		private function zero():Number {
			return 0;
		}
	}
}
import flash.display.Sprite;
import flash.display.BitmapData;
import flash.display.Bitmap;
import flash.text.TextField;
class DrawBitmap extends Sprite{
	private var w:Number = 465;
	private var h:Number = 142;
	private var bmp_data:BitmapData = new BitmapData(w,h, false , 0x000000);
	private var bmp:Bitmap = new Bitmap(bmp_data);
	private var text_field:TextField = new TextField();
	function DrawBitmap(ta:Object,_x:Number,_y:Number){
		bmp.x = _x*w;
		bmp.y = 155*_y+12;
		ta.addChild(bmp);
		text_field.x = _x*w;
		text_field.y = 155*_y;
		text_field.height=50;
		text_field.width = w;
		ta.addChild(text_field);
	}
	
	public function txt(_str:String):void{
		text_field.text=_str;
	}
	public function pxy(numX:Number,numY:Number):void{
		var _x:int = int(numX*w);
		var _y:int = int(numY*h);
		if(bmp_data.getPixel(_x,_y) < 0x11){
			bmp_data.setPixel(_x,_y ,0x11);
		}else if(bmp_data.getPixel(_x,_y) < 0x22){
			bmp_data.setPixel(_x,_y ,0x22);
		}else if(bmp_data.getPixel(_x,_y) < 0x33){
			bmp_data.setPixel(_x,_y ,0x33);
		}else if(bmp_data.getPixel(_x,_y) < 0x44){
			bmp_data.setPixel(_x,_y ,0x44);
		}else if(bmp_data.getPixel(_x,_y) < 0x55){
			bmp_data.setPixel(_x,_y ,0x55);
		}else if(bmp_data.getPixel(_x,_y) < 0x66){
			bmp_data.setPixel(_x,_y ,0x66);
		}else if(bmp_data.getPixel(_x,_y) < 0x77){
			bmp_data.setPixel(_x,_y ,0x77);
		}else if(bmp_data.getPixel(_x,_y) < 0x88){
			bmp_data.setPixel(_x,_y ,0x88);
		}else if(bmp_data.getPixel(_x,_y) < 0x99){
			bmp_data.setPixel(_x,_y ,0x99);
		}else if(bmp_data.getPixel(_x,_y) < 0xAA){
			bmp_data.setPixel(_x,_y ,0xAA);
		}else if(bmp_data.getPixel(_x,_y) < 0xBB){
			bmp_data.setPixel(_x,_y ,0xBB);
		}else if(bmp_data.getPixel(_x,_y) < 0xCC){
			bmp_data.setPixel(_x,_y ,0xCC);
		}else if(bmp_data.getPixel(_x,_y) < 0xDD){
			bmp_data.setPixel(_x,_y ,0xDD);
		}else if(bmp_data.getPixel(_x,_y) < 0xEE){
			bmp_data.setPixel(_x,_y ,0xEE);
		}else if(bmp_data.getPixel(_x,_y) < 0xFF){
			bmp_data.setPixel(_x,_y ,0xFF);
		}else{
			bmp_data.setPixel(_x,_y ,0xFF0000);
		}
	}
}
/*
線形合同法

randomSeedを与えた場合は、100回実行して偏りを抑える。

参考
http://hp.vector.co.jp/authors/VA004808/random1.html
http://d.hatena.ne.jp/keyword/%C0%FE%B7%C1%B9%E7%C6%B1%CB%A1
*/
class Mas extends Sprite{
	private static var num:Number = 1;
	public static function randomSeed(s:Number):void{
		num = s;
		for (var i:int = 0; i < 100; i++) {
			random();
		}
	}
	public static function random():Number{
		num = (num*1664525+1013904223)%0x100000000;
		return num/0x100000000;
	}
}


/*
SFMT 簡易版クラス
author:kimura@sionnet.jp
http://www.eqliquid.com/blog/2009/02/sfmt-actionscript-30.html
から抜き出した。

umhrにより使いやすいようにごく一部修正した。
umhrによる修正や使い方によって、
重大な問題が発生している可能性があるので、
「SFMT 簡易版クラス」やSFMT自体の評価は別途行うこと。



以下、元のReadme_jp.txtよりコピペ
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
以上、元のReadme_jp.txtよりコピペ
*/

class Sfmt 
{
	private var index:int;
	private var x:Vector.<int> = new Vector.<int>(624);//状態テーブル
	
	/**
	 * コンストラクタ<br />
	 * 初期化する
	 * @param	s	整数のシード
	 */
	public function Sfmt(s:int) 
	{
		initMt(s);
	}
	
	private function genRandAll():void
	{
		var a:int = 0;
		var b:int = 488;
		var c:int = 616;
		var d:int = 620;
		var y:int;
		var p:Vector.<int> = x;//Javaの振る舞い、処理の内容からシャローコピーと判断
		
		do
		{
			y = p[a + 3] ^ (p[a + 3] << 8) ^ (p[a + 2] >>> 24) ^ ((p[b + 3] >>> 11) & 0xbffffff6);
			p[a + 3] = y ^ (p[c + 3] >>> 8) ^ (p[d + 3] << 18);
			y = p[a + 2] ^ (p[a + 2] << 8) ^ (p[a + 1] >>> 24) ^ ((p[b + 2] >>> 11) & 0xbffaffff);
			p[a + 2] = y ^ ((p[c + 2] >>> 8) | (p[c + 3] << 24)) ^ (p[d + 2] << 18);
			y = p[a + 1] ^ (p[a + 1] << 8) ^ (p[a] >>> 24) ^ ((p[b + 1] >>> 11) & 0xddfecb7f);
			p[a + 1] = y ^ ((p[c + 1] >>> 8) | (p[c + 2] << 24)) ^ (p[d + 1] << 18);
			y = p[a] ^ (p[a] << 8) ^ ((p[b] >>> 11) & 0xdfffffef);
			p[a] = y ^ ((p[c] >>> 8) | (p[c + 1] << 24)) ^ (p[d] << 18);
			c = d;
			d = a;
			a += 4;
			b += 4;
			if (b == 624) b = 0;
		}
		while (a != 624);
	}
	
	private function periodCertification():void
	{
		var work:int;
		var inner:int = 0;
		var i:int;
		var j:int;
		var parity:Vector.<int> = new Vector.<int>(4);
		parity.push(0x00000001);
		parity.push(0x00000000);
		parity.push(0x00000000);
		parity.push(0x13c9e684);
		index = 624;
		
		for (i = 0; i < 4; i++)
		{
			inner ^= x[i] & parity[i];
		}
		for (i = 16; i > 0; i >>>= 1)
		{
			inner ^= inner >>> i;
		}
		inner &= 1;
		if (inner == 1) return;
		for (i = 0; i < 4; i++)
		{
			for (j = 0, work = 1; j < 32; j++, work <<= 1 )
			{
				if ((work & parity[i]) != 0)
				{
					x[i] ^= work;
					return;
				}
			}
		}
		
	}
	
	/**
	 * 初期化
	 * @param	s	整数のシード
	 */
	private function initMt(s:int):void
	{
		x[0] = s;
		for (var p:int; p < 624; p++)
		{
			s = 1812433253 * (s ^ (s >>> 30)) + p;
			x[p] = s;
		}
		periodCertification();
	}
	
	/**
	 * 32ビット符号あり整数乱数を返す
	 * @return 32ビット符号あり整数乱数
	 */
	public function nextMt():int
	{
		if (index == 624)
		{
			genRandAll();
			index = 0;
		}
		return x[index++];
	}
	
	/**
	 * 0 以上 n 未満の整数乱数を返す
	 * @param	n	乱数の上限値にする整数
	 * @return	0 以上 n 未満の整数乱数
	 */
	public function nextInt(n:int):int
	{
		var z:Number = nextMt();
		if (z < 0) z += 4294967296.0;
		return int(n * (1.0 / 4294967296.0) * z);
	}
	
	/**
	 * umhrによる追加
	 * 0 以上 1 未満の乱数(32ビット精度)を返す
	 * @return	0 以上 1 未満の乱数(32ビット精度)
	 */
	public function random():Number
	{
		var z:Number = nextMt();
		if (z < 0){ z += 4294967296};
		return z / 4294967296;
	}
	
	/**
	 * 0 以上 1 未満の乱数(53ビット精度)を返す
	 * @return	0 以上 1 未満の乱数(53ビット精度)
	 */
	public function nextUnif():Number
	{
		var z:Number = nextMt() >>> 11;
		var y:Number = nextMt();
		if (y < 0) y += 4294967296.0;
		return (y * 2097152.0 + z) * (1.0 / 9007199254740992.0);
	}
	
}
