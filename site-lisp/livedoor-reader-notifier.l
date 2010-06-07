; -*- Mode: Lisp; Package: Editor -*-

#|
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

see livedoor-reader-notifier/MIT-LICENSE.

|#

(in-package "editor")

(require "xml-http-request")

(export '(*livedoor-reader-notifier-user*
          *livedoor-reader-notifier-update-interval*
          *livedoor-reader-notifier-open-browser-function*
          *livedoor-reader-notifier-quiet*
          livedoor-reader-notifier-update-unread))

(defvar *livedoor-reader-notifier-user* nil
  "livedoor-reader-notifier: livedoor ID")

(defvar *livedoor-reader-notifier-update-interval* 10
  "livedoor-reader-notifier: �X�V�Ԋu (��)")

(defvar *livedoor-reader-notifier-open-browser-function* nil
  "livedoor-reader-notifier: �u���E�U���J�����߂̃R�}���h or ������")

(defvar *livedoor-reader-notifier-quiet* nil
  "livedoor-reader-notifier: non-nil �Ȃ�Î⃂�[�h")



(defvar *livedoor-reader-notifier-format* "livedoor Reader - ~A ���̖���")
(defvar *livedoor-reader-notifier-reader-url* "http://reader.livedoor.com/reader/")
(defvar *livedoor-reader-notifier-rpc-url* "http://rpc.reader.livedoor.com/notify?user=")

(defvar *livedoor-reader-notifier-menu-tag* 'livedoor-reader-notifier)
(defvar *livedoor-reader-notifier-menu-position* '(ed::tools 0))

(defvar *livedoor-reader-notifier-unread* nil)

(defvar *livedoor-reader-notifier-last-updated-date* nil)
(defconstant *livedoor-reader-notifier-unix-epoch* (encode-universal-time 0 0 0 1 1 1970 0))


(defun livedoor-reader-notifier-user ()
  (unless *livedoor-reader-notifier-user*
    (setf *livedoor-reader-notifier-user*
          (or (read-registry "Software\\livedoor\\Notifier" "livedoor ID" :current-user)
              (read-string "livedoor Reader login user: "))))
  *livedoor-reader-notifier-user*)

(defun livedoor-reader-notifier-rpc-url ()
  (concat *livedoor-reader-notifier-rpc-url*
          (livedoor-reader-notifier-user)))

(defun livedoor-reader-notifier-set-interval (minutes)
  (interactive "n�X�V�Ԋu (��): ")
  (setf *livedoor-reader-notifier-update-interval* minutes)
  (livedoor-reader-notifier-start-update-timer))

(defun livedoor-reader-notifier-update-interval-sec ()
  (let ((dt *livedoor-reader-notifier-update-interval*))
    (when dt
      (* 60 (max dt 1)))))   ;; �Œ�ł� 1 ���Ԋu��

(defun livedoor-reader-notifier-format ()
  (format nil *livedoor-reader-notifier-format*
          (case *livedoor-reader-notifier-unread*
            ((nil) "???")
            (-1 "���O�C��ID���Ⴂ�܂�")
            (t *livedoor-reader-notifier-unread*))))

(defun livedoor-reader-notifier-open-browser ()
  (interactive)
  (let ((fun *livedoor-reader-notifier-open-browser-function*)
        (url *livedoor-reader-notifier-reader-url*))
    (cond ((stringp fun)
           (call-process (format nil "\"~A\" ~A" fun url)))
          ((functionp fun)
           (funcall fun url))
          (t
           (shell-execute url t)))))

(defun livedoor-reader-notifier-update-unread ()
  (interactive)
  (xml-http-request:http-get (livedoor-reader-notifier-rpc-url)
                             :headers (list (cons "If-Modified-Since"
                                                  (livedoor-reader-notifier-last-updated-date-rfc822)))
                             :onsuccess #'livedoor-reader-notifier-update-onsuccess
                             :onfailure #'livedoor-reader-notifier-update-onfailure
                             :oncomplete #'livedoor-reader-notifier-update-oncomplete)
  (setf *livedoor-reader-notifier-last-updated-date* (get-universal-time)))

(defun livedoor-reader-notifier-update-onsuccess (transport)
  (let ((result (split-string
                 (xml-http-request:response-text transport)
                 #\| t)))
    (setf *livedoor-reader-notifier-unread*
          (parse-integer (cadr result) :junk-allowed t))))

(defun livedoor-reader-notifier-update-onfailure (transport)
  (setf *livedoor-reader-notifier-unread* nil))

(defun livedoor-reader-notifier-update-oncomplete (transport)
  (livedoor-reader-notifier-message
   (format nil "~A (~A)"
           (livedoor-reader-notifier-format)
           (format-date-string "%Y-%m-%d %H:%M:%S")))
  (livedoor-reader-notifier-update-menu))

(defun livedoor-reader-notifier-update-menu (&optional (path *livedoor-reader-notifier-menu-position*))
  (multiple-value-bind (pos menu)
      (livedoor-reader-notifier-find-menu path)
    (let ((curr (get-menu-position menu *livedoor-reader-notifier-menu-tag*)))
      (when curr
        (delete-menu menu curr t))
      (multiple-value-bind (pos menu)
          (livedoor-reader-notifier-find-menu path)
        (insert-menu-item menu pos
                          *livedoor-reader-notifier-menu-tag*
                          (livedoor-reader-notifier-format)
                          'livedoor-reader-notifier-open-browser)))))

(defun livedoor-reader-notifier-find-menu (path &optional (menu *app-menu*))
  (cond ((endp path)
         nil)
        ((= (length path) 1)
         (if (numberp (car path))
             (values (car path) menu)
           (get-menu-position menu (car path))))
        (t
         (livedoor-reader-notifier-find-menu
          (cdr path)
          (get-menu menu (car path) (numberp (car path)))))))

(defun livedoor-reader-notifier-message (msg)
  (unless *livedoor-reader-notifier-quiet*
    (message msg)))

(defun livedoor-reader-notifier-last-updated-date-rfc822 ()
  (livedoor-reader-notifier-rfc822-format-date
   (or *livedoor-reader-notifier-last-updated-date*
       *livedoor-reader-notifier-unix-epoch*)))

(defun livedoor-reader-notifier-last-updated-date ()
  (let ((last-up *livedoor-reader-notifier-last-updated-date*))
    (when last-up
      (livedoor-reader-notifier-format-date last-up))))

(defun livedoor-reader-notifier-next-update-date ()
  (let ((last-up *livedoor-reader-notifier-last-updated-date*)
        (dt (livedoor-reader-notifier-update-interval-sec)))
    (when (and last-up dt)
      (livedoor-reader-notifier-format-date (+ last-up dt)))))

(defun livedoor-reader-notifier-format-date (dt)
  (format-date-string "%Y-%m-%d %H:%M:%S" dt))

;; junk/lib.l ����q�� m(__)m
(defun livedoor-reader-notifier-rfc822-format-date (&optional time (tzdiff 9))
  "Date�w�b�_�[���������ĕԂ��B(ex.Date: Sun, 12 Sep 1999 13:18:13 GMT)"
  (setq time (- (or time (get-universal-time)) (* tzdiff 60 60)))
  (format-date-string "%a, %d %b %Y %H:%M:%S GMT" time))


;; *livedoor-reader-notifier-update-interval* �������ɔ��f�����悤��
;; one-shot �Ŏ��s����B
(defun livedoor-reader-notifier-start-update-timer ()
  (while (stop-timer 'livedoor-reader-notifier-update-unread))
  (let ((dt (livedoor-reader-notifier-update-interval-sec)))
    (when (and dt (< 0 dt))
      (livedoor-reader-notifier-update-unread)
      (start-timer dt 'livedoor-reader-notifier-start-update-timer t))))

;; �Ƃ肠�������j���[��ǉ����Ă���
(add-hook '*init-app-menus-hook* 'livedoor-reader-notifier-update-menu)

;; *post-startup-hook* �̒��� *livedoor-reader-notifier-user* �Ƃ���
;; �ݒ肵�Ă��邩������Ȃ��̂ŁA���S�ɋN�����Ă�����s����悤�ɂ���
(defvar *livedoor-reader-notifier-startup-delay* 5)
(add-hook '*post-startup-hook*
          #'(lambda ()
              (start-timer *livedoor-reader-notifier-startup-delay*
                           'livedoor-reader-notifier-start-update-timer t)))


;;
;; livedoor-reader-notifier.l ����_(�Oo�O)�^
;;