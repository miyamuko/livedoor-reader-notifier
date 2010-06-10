= livedoor-reader-notifier - livedoor Reader �̖��ǐ��� xyzzy ��ɕ\��

  * Author: MIYAMUKO Katsuyuki ((<URL:mailto:miyamuko (at) gmail.com>))
  * URL: ((<URL:http://miyamuko.s56.xrea.com/xyzzy/livedoor-reader-notifier/intro.htm>))
  * Version: 0.2


== SYNOPSIS

* �u�c�[���v���j���[���ɖ��ǐ����\������܂��B
  �N���b�N����ƃu���E�U���N������ livedoor Reader ���J���܂��B

* �������ɖ��ǐ����X�V�������ꍇ�͈ȉ��̃R�}���h���~�j�o�b�t�@������s���܂��B

    M-x livedoor-reader-notifier-update-unread


== DESCRIPTION

livedoor-reader-notifier �� livedoor Reader �̖��ǐ��� xyzzy ��ɕ\�����܂��B
�f�t�H���g�̐ݒ�ł� 10 ���� 1 ��A���ǐ����擾�����j���[�ɕ\�����܂��B

�T�[�o�ւ̖₢���킹�͔񓯊��ɍs���Ă���̂ŁA���ǐ��̎擾���� xyzzy
��ł̍�Ƃ��ז����܂���B

((<"xml-http-request"|URL:http://miyamuko.s56.xrea.com/xyzzy/xml-http-request.html>))
���C���X�g�[������K�v������܂��B


=== INSTALL

((<NetInstaller|URL:http://www7a.biglobe.ne.jp/~hat/xyzzy/ni.html>)) �ŃC���X�g�[�������ꍇ�� 4 �ȍ~���A
NetInstaller + (({ni-autoload})) ���g���Ă���l�� 5 �ȍ~�� OK �ł��B

(1) ((<"xml-http-request"|URL:http://miyamuko.s56.xrea.com/xyzzy/xml-http-request.html>))
    ���C���X�g�[�����܂��B

(2) �A�[�J�C�u���_�E�����[�h���܂��B

    ((<URL:http://miyamuko.s56.xrea.com/xyzzy/archives/livedoor-reader-notifier.zip>))

(3) �A�[�J�C�u��W�J���āA$XYZZY/site-lisp �z���Ƀt�@�C�����R�s�[���܂��B

(4) ~/.xyzzy �܂��� $XYZZY/site-lisp/siteinit.l �Ɉȉ��̃R�[�h��ǉ����܂��B

        ;; livedoor-reader-notifier
        (require "livedoor-reader-notifier")

(5) livedoor Reader �̃��O�C�����[�U����ݒ肵�܂��B

    �� ((< *livedoor-reader-notifier-user* >))

(6) �ݒ�𔽉f�����邽�� xyzzy ���ċN�����Ă��������B

    ��siteinit.l �ɋL�q�����ꍇ�ɂ͍ă_���v���K�v�ł��B


=== PACKAGE

livedoor-reader-notifier �͈ȉ��̃p�b�P�[�W�𗘗p���Ă��܂��B

* editor

  prefix �� livedoor-reader-notifier- �ł��B


=== VARIABLE

--- *livedoor-reader-notifier-user*

    livedoor Reader �̃��O�C�� ID ��ݒ肵�܂��B

    * ((<"livedoor Reader Notifier for Windows"|URL:http://reader.livedoor.com/utility/notifier/>))
      ���C���X�g�[������Ă���ꍇ�͐ݒ肷��K�v�͂���܂��� (���W�X�g������擾���܂�)�B

    * ���O�C�� ID ���ݒ肳��Ă��Ȃ��ꍇ�̓~�j�o�b�t�@����₢���킹�܂��B

        ;; ���O�C�� ID �̐ݒ�
        (setf *livedoor-reader-notifier-user* "���Ȃ��̃��O�C�� ID")


--- *livedoor-reader-notifier-update-interval*

    ���ǐ��̖₢���킹�Ԋu�𕪒P�ʂŎw�肵�܂��B
    �f�t�H���g�� 10 (�� 10 ��) �ł��B
    0 �ȉ��̒l�� nil ���w�肷��ƍX�V��������~���܂��B

        ;; �X�V�Ԋu�� 30 ���ɂ���
        (setf *livedoor-reader-notifier-update-interval* 30)

    xyzzy �N�����ɂ��̕ϐ���ύX�����ꍇ�A���̍X�V���ɍX�V�Ԋu���ύX����܂��B

    �Ⴆ�΁A1 ���ԊԊu�ōX�V���Ă����Ƃ���:

    * (A) �̃^�C�~���O�� 30 ���Ԋu�ɕύX����ƁA
    * (B) �̃^�C�~���O�Ŕ��f����܂��B

        0:00        1:00        2:00        3:00
        |-----+-----|-----+-----|-----+-----|---
        *           *           *     *     *
                      (A)      (B)

    ed::livedoor-reader-notifier-set-interval �֐��𗘗p����Ƃ����ɔ��f����܂��B

        ;; �X�V�Ԋu�� 30 ���ɂ��� (�����ɔ��f)
        (ed::livedoor-reader-notifier-set-interval 30)

    �ȉ��̂悤�ɂȂ�܂��B

        0:00        1:00        2:00        3:00
        |-----+-----|-----+-----|-----+-----|---
        *           *  *     *     *     *     *
                      (A)
                      (B)

--- *livedoor-reader-notifier-open-browser-function*

    livedoor Reader ���J�����@���w�肵�܂��B

    : ������
        ��������w�肵���ꍇ�R�}���h�ƌ��Ȃ��܂��B
        livedoor Reader �� URL �������ɂ��Ďw�肳�ꂽ�R�}���h�����s���܂��B

            ;; firefox �Ŏ��s
            (setf *livedoor-reader-notifier-open-browser-function*
                  "C:/Program Files/Mozilla Firefox/firefox.exe")

    : �֐�
        �֐����w�肵���ꍇ URL �������ɂ��Ďw�肳�ꂽ�֐������s���܂��B

            ;; browser-ex �Ŏ��s
            (setf *livedoor-reader-notifier-open-browser-function*
                  #'(lambda (url)
                      (bx:navigate url)))

    : nil
        URL �Ɋ֘A�t�����Ă���f�t�H���g�u���E�U�ŊJ���܂��B


    �f�t�H���g�� nil (�f�t�H���g�u���E�U�ŊJ��) �ł��B


--- *livedoor-reader-notifier-quiet*

    ���̕ϐ��� non-nil ��ݒ肷��ƐÎ⃂�[�h�ɂȂ�܂��B
    nil �̏ꍇ���ǐ��擾���ɃX�e�[�^�X�̈�ɖ��ǐ���\�����܂��B

    �f�t�H���g�� nil �ł��B


=== COMMAND

--- livedoor-reader-notifier-update-unread

    livedoor Reader �̖��ǐ����X�V���܂��B

--- ed::livedoor-reader-notifier-set-interval minutes

    �X�V�Ԋu��ύX���܂��B


=== FUNCTION

�Ȃ��B


=== EXPORT

==== editor

editor �p�b�P�[�W����͈ȉ��̕ϐ��ƃR�}���h�� export ���Ă��܂��B

* ((< *livedoor-reader-notifier-user* >))
* ((< *livedoor-reader-notifier-update-interval* >))
* ((< *livedoor-reader-notifier-open-browser-function* >))
* ((< *livedoor-reader-notifier-quiet* >))
* ((< livedoor-reader-notifier-update-unread >))


== TODO

* ���j���[�ɒǉ�����ꏊ�̎w����_��ɁB
* �����������X�V�ʒm�B
* ����炷�B
* �G���[�����������Ƃ܂��߂ɁB
* �u�������X�V�v���j���[
* �c�[���o�[�ɃA�C�R����ǉ��B
  * tooltip �Ŗ��ǐ���\���B


== KNOWN BUGS

�Ȃ��B


== AUTHORS

�݂�ނ� ���䂫 (((<URL:mailto:miyamuko (at) gmail.com>)))


== SEE ALSO

: livedoor Reader - RSS���[�_�[ : �X�V�ʒm�A�v���P�[�V�����iNotifier�j
    ((<URL:http://reader.livedoor.com/utility/notifier/>))

: xml-http-request
    ((<URL:http://miyamuko.s56.xrea.com/xyzzy/xml-http-request.html>))


== COPYRIGHT

livedoor-reader-notifier �� MIT/X ���C�Z���X�Ɋ�Â��ė��p�\�ł��B

see livedoor-reader-notifier/docs/MIT-LICENSE for full license.
