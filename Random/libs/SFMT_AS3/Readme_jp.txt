Readme_jp.txt

====================

SFMT �ȈՔŃN���X
author:kimura@sionnet.jp

�p�b�P�[�W:

jp.sionnet.utils.Sfmt

====================

�T�v:
�v�񂷂�΁A���x�ȋ[�������𔭐����郁���Z���k�E�c�C�X�^�̍����ł�SFMT�ł��B
����SFMT�̊e����ł����J����Ă���isaku����̊ȈՔŃ��C�u������ActionScript3.0�ɈڐA�������̂ł��B
���e�͂����Ƃ������ł��ĂȂ��̂ŁA�ԈႢ���������炲�w�E����������ƍK���ł��B

SFMT:
http://www.math.sci.hiroshima-u.ac.jp/~m-mat/MT/SFMT/index-jp.html

�������C�u����:
http://www001.upp.so-net.ne.jp/isaku/rand2.html


���C�Z���X:
SFMT�̃��C�Z���X�Ɉ˂�܂��B2009�N2�����݁A�C��BSD���C�Z���X�ł��B

====================

�g����:
�N���X�p�X�ɒǉ�����import���Ă��������B
�R���X�g���N�^�ւ͐����̃V�[�h��^���܂��B�����V�[�h�Ȃ�\���\�Ȓl��Ԃ��܂��B
�ʂȒl��Ԃ��C���X�^���X���쐬����ꍇ�͈Ⴄ�V�[�h��^���Ă��������B

��:
mySfmt1 = new Sfmt(1);
mySfmt2 = new Sfmt(2);//����2�̃C���X�^���X�͕ʂȒl��Ԃ�

�񋟂��郁�\�b�h:
�ڐA���̊ȈՔłƓ������\�b�h�������܂��B

nextMt()        32�r�b�g�����Ȃ������̗���:int
nextUnif()      0 �ȏ� 1 �����̗���(53�r�b�g���x):Number
nextInt(N)      0 �ȏ� N �����̐�������:int


��:SfmtTest.as
~~~~~~~~~~~~~~~~~~~~~~~~
package
{
	import flash.display.Sprite;
	import jp.sionnet.utils.Sfmt;
	
	/**
	 * SFMT�����̃e�X�g
	 */
	public class SfmtTest extends Sprite
	{
		public var mySfmt:Sfmt;
		
		public function SfmtTest() 
		{
			mySfmt = new Sfmt(1);//�V�[�h1�ŏ�����
			sfmtTracer(100);//100�̗�����trace
		}
		
		private function sfmtTracer(n:uint):void
		{
			for (var i:uint = 0; i < n; i++)
			{
				trace(mySfmt.nextInt(100));//0�ȏ�100�����̐���������\��
			}
		}
		
	}
	
}
~~~~~~~~~~~~~~~~~~~~~~~~
