; -*- Mode: Lisp; Package: Editor -*-

#|
= livedoor-reader-notifier - livedoor Reader の未読数を xyzzy 上に表示

  * Author: MIYAMUKO Katsuyuki ((<URL:mailto:miyamuko (at) gmail.com>))
  * URL: ((<URL:http://miyamuko.s56.xrea.com/xyzzy/livedoor-reader-notifier/intro.htm>))
  * Version: 0.2


== SYNOPSIS

* 「ツール」メニュー内に未読数が表示されます。
  クリックするとブラウザが起動して livedoor Reader を開きます。

* 今すぐに未読数を更新したい場合は以下のコマンドをミニバッファから実行します。

    M-x livedoor-reader-notifier-update-unread


== DESCRIPTION

livedoor-reader-notifier は livedoor Reader の未読数を xyzzy 上に表示します。
デフォルトの設定では 10 分に 1 回、未読数を取得しメニューに表示します。

サーバへの問い合わせは非同期に行っているので、未読数の取得中も xyzzy
上での作業を邪魔しません。

((<"xml-http-request"|URL:http://miyamuko.s56.xrea.com/xyzzy/xml-http-request.html>))
をインストールする必要があります。


=== INSTALL

((<NetInstaller|URL:http://www7a.biglobe.ne.jp/~hat/xyzzy/ni.html>)) でインストールした場合は 4 以降を、
NetInstaller + (({ni-autoload})) を使っている人は 5 以降で OK です。

(1) ((<"xml-http-request"|URL:http://miyamuko.s56.xrea.com/xyzzy/xml-http-request.html>))
    をインストールします。

(2) アーカイブをダウンロードします。

    ((<URL:http://miyamuko.s56.xrea.com/xyzzy/archives/livedoor-reader-notifier.zip>))

(3) アーカイブを展開して、$XYZZY/site-lisp 配下にファイルをコピーします。

(4) ~/.xyzzy または $XYZZY/site-lisp/siteinit.l に以下のコードを追加します。

        ;; livedoor-reader-notifier
        (require "livedoor-reader-notifier")

(5) livedoor Reader のログインユーザ名を設定します。

    → ((< *livedoor-reader-notifier-user* >))

(6) 設定を反映させるため xyzzy を再起動してください。

    ※siteinit.l に記述した場合には再ダンプが必要です。


=== PACKAGE

livedoor-reader-notifier は以下のパッケージを利用しています。

* editor

  prefix は livedoor-reader-notifier- です。


=== VARIABLE

--- *livedoor-reader-notifier-user*

    livedoor Reader のログイン ID を設定します。

    * ((<"livedoor Reader Notifier for Windows"|URL:http://reader.livedoor.com/utility/notifier/>))
      がインストールされている場合は設定する必要はありません (レジストリから取得します)。

    * ログイン ID が設定されていない場合はミニバッファから問い合わせます。

        ;; ログイン ID の設定
        (setf *livedoor-reader-notifier-user* "あなたのログイン ID")


--- *livedoor-reader-notifier-update-interval*

    未読数の問い合わせ間隔を分単位で指定します。
    デフォルトは 10 (＝ 10 分) です。
    0 以下の値や nil を指定すると更新処理が停止します。

        ;; 更新間隔を 30 分にする
        (setf *livedoor-reader-notifier-update-interval* 30)

    xyzzy 起動中にこの変数を変更した場合、次の更新時に更新間隔が変更されます。

    例えば、1 時間間隔で更新していたときに:

    * (A) のタイミングで 30 分間隔に変更すると、
    * (B) のタイミングで反映されます。

        0:00        1:00        2:00        3:00
        |-----+-----|-----+-----|-----+-----|---
        *           *           *     *     *
                      (A)      (B)

    ed::livedoor-reader-notifier-set-interval 関数を利用するとすぐに反映されます。

        ;; 更新間隔を 30 分にする (すぐに反映)
        (ed::livedoor-reader-notifier-set-interval 30)

    以下のようになります。

        0:00        1:00        2:00        3:00
        |-----+-----|-----+-----|-----+-----|---
        *           *  *     *     *     *     *
                      (A)
                      (B)

--- *livedoor-reader-notifier-open-browser-function*

    livedoor Reader を開く方法を指定します。

    : 文字列
        文字列を指定した場合コマンドと見なします。
        livedoor Reader の URL を引数にして指定されたコマンドを実行します。

            ;; firefox で実行
            (setf *livedoor-reader-notifier-open-browser-function*
                  "C:/Program Files/Mozilla Firefox/firefox.exe")

    : 関数
        関数を指定した場合 URL を引数にして指定された関数を実行します。

            ;; browser-ex で実行
            (setf *livedoor-reader-notifier-open-browser-function*
                  #'(lambda (url)
                      (bx:navigate url)))

    : nil
        URL に関連付けられているデフォルトブラウザで開きます。


    デフォルトは nil (デフォルトブラウザで開く) です。


--- *livedoor-reader-notifier-quiet*

    この変数に non-nil を設定すると静寂モードになります。
    nil の場合未読数取得時にステータス領域に未読数を表示します。

    デフォルトは nil です。


=== COMMAND

--- livedoor-reader-notifier-update-unread

    livedoor Reader の未読数を更新します。

--- ed::livedoor-reader-notifier-set-interval minutes

    更新間隔を変更します。


=== FUNCTION

なし。


=== EXPORT

==== editor

editor パッケージからは以下の変数とコマンドを export しています。

* ((< *livedoor-reader-notifier-user* >))
* ((< *livedoor-reader-notifier-update-interval* >))
* ((< *livedoor-reader-notifier-open-browser-function* >))
* ((< *livedoor-reader-notifier-quiet* >))
* ((< livedoor-reader-notifier-update-unread >))


== TODO

* メニューに追加する場所の指定を柔軟に。
* かっこいい更新通知。
* 音を鳴らす。
* エラー処理をもっとまじめに。
* 「今すぐ更新」メニュー
* ツールバーにアイコンを追加。
  * tooltip で未読数を表示。


== KNOWN BUGS

なし。


== AUTHORS

みやむこ かつゆき (((<URL:mailto:miyamuko (at) gmail.com>)))


== SEE ALSO

: livedoor Reader - RSSリーダー : 更新通知アプリケーション（Notifier）
    ((<URL:http://reader.livedoor.com/utility/notifier/>))

: xml-http-request
    ((<URL:http://miyamuko.s56.xrea.com/xyzzy/xml-http-request.html>))


== COPYRIGHT

livedoor-reader-notifier は MIT/X ライセンスに基づいて利用可能です。

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
  "livedoor-reader-notifier: 更新間隔 (分)")

(defvar *livedoor-reader-notifier-open-browser-function* nil
  "livedoor-reader-notifier: ブラウザを開くためのコマンド or 文字列")

(defvar *livedoor-reader-notifier-quiet* nil
  "livedoor-reader-notifier: non-nil なら静寂モード")



(defvar *livedoor-reader-notifier-format* "livedoor Reader - ~A 件の未読")
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
  (interactive "n更新間隔 (分): ")
  (setf *livedoor-reader-notifier-update-interval* minutes)
  (livedoor-reader-notifier-start-update-timer))

(defun livedoor-reader-notifier-update-interval-sec ()
  (let ((dt *livedoor-reader-notifier-update-interval*))
    (when dt
      (* 60 (max dt 1)))))   ;; 最低でも 1 分間隔で

(defun livedoor-reader-notifier-format ()
  (format nil *livedoor-reader-notifier-format*
          (case *livedoor-reader-notifier-unread*
            ((nil) "???")
            (-1 "ログインIDが違います")
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

;; junk/lib.l から拝借 m(__)m
(defun livedoor-reader-notifier-rfc822-format-date (&optional time (tzdiff 9))
  "Dateヘッダー書式化して返す。(ex.Date: Sun, 12 Sep 1999 13:18:13 GMT)"
  (setq time (- (or time (get-universal-time)) (* tzdiff 60 60)))
  (format-date-string "%a, %d %b %Y %H:%M:%S GMT" time))


;; *livedoor-reader-notifier-update-interval* がすぐに反映されるように
;; one-shot で実行する。
(defun livedoor-reader-notifier-start-update-timer ()
  (while (stop-timer 'livedoor-reader-notifier-update-unread))
  (let ((dt (livedoor-reader-notifier-update-interval-sec)))
    (when (and dt (< 0 dt))
      (livedoor-reader-notifier-update-unread)
      (start-timer dt 'livedoor-reader-notifier-start-update-timer t))))

;; とりあえずメニューを追加しておく
(add-hook '*init-app-menus-hook* 'livedoor-reader-notifier-update-menu)

;; *post-startup-hook* の中で *livedoor-reader-notifier-user* とかを
;; 設定しているかもしれないので、完全に起動してから実行するようにする
(defvar *livedoor-reader-notifier-startup-delay* 5)
(add-hook '*post-startup-hook*
          #'(lambda ()
              (start-timer *livedoor-reader-notifier-startup-delay*
                           'livedoor-reader-notifier-start-update-timer t)))


;;
;; livedoor-reader-notifier.l ｵﾜﾀ＼(＾o＾)／
;;
