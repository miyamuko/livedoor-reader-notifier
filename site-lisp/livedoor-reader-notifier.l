; -*- mode: lisp; package: editor -*-

;; livedoor-reader-notifier.l
;;
;;   Copyright (c) 2006 MIYAMUKO Katsuyuki.
;;
;;   See livedoor-reader-notifier/docs/MIT-LICENSE for full license.
;;


(in-package "editor")

(require "xml-http-request")

(export '(*livedoor-reader-notifier-user*
          *livedoor-reader-notifier-update-interval*
          *livedoor-reader-notifier-open-browser-function*
          *livedoor-reader-notifier-quiet*
          *livedoor-reader-notifier-notify-threshold*
          *livedoor-reader-notifier-disable-p*
          livedoor-reader-notifier-update-unread))

(defvar *livedoor-reader-notifier-user* nil
  "livedoor-reader-notifier: livedoor ID")

(defvar *livedoor-reader-notifier-update-interval* 10
  "livedoor-reader-notifier: 更新間隔 (分)")

(defvar *livedoor-reader-notifier-open-browser-function* nil
  "livedoor-reader-notifier: ブラウザを開くためのコマンド or 文字列")

(defvar *livedoor-reader-notifier-quiet* nil
  "livedoor-reader-notifier: non-nil なら静寂モード")

(defvar *livedoor-reader-notifier-notify-threshold* 0
  "livedoor-reader-notifier: 更新数がこれ以下なら無視する")

(defvar *livedoor-reader-notifier-disable-p* nil
  "livedoor-reader-notifier: 未読数が 0 ならメニューを disable にするなら t")

(defvar *livedoor-reader-notifier-after-update-hooks*
  '(livedoor-reader-notifier-filter-unread-hook
    livedoor-reader-notifier-message-hook)
  "livedoor-reader-notifier: 未読数取得後に実行するフック。メニューの更新前に実行される。")


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
      (* 60 (max dt 1)))))   ; 最低でも 1 分間隔で

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
  (run-hook-with-args '*livedoor-reader-notifier-after-update-hooks*
                      *livedoor-reader-notifier-unread*)
  (livedoor-reader-notifier-update-menu))


;;;; menu

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
                          'livedoor-reader-notifier-open-browser
                          #'(lambda ()
                              (when (and *livedoor-reader-notifier-disable-p*
                                         (zerop *livedoor-reader-notifier-unread*))
                                :disable)))))))

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


;;;; hooks

(defun livedoor-reader-notifier-filter-unread-hook (n)
  (when (and (numberp n)
             (plusp n)
             (< n *livedoor-reader-notifier-notify-threshold*))
    (setf *livedoor-reader-notifier-unread* 0)))

(defun livedoor-reader-notifier-message-hook (n)
  (livedoor-reader-notifier-message
   (format nil "~A (~A)"
           (livedoor-reader-notifier-format)
           (livedoor-reader-notifier-last-updated-date))))


;;;; date

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

(defun livedoor-reader-notifier-rfc822-format-date (date)
  (format-date-string "%a, %d %b %Y %H:%M:%S GMT" date))


;;;; util

(defun livedoor-reader-notifier-message (msg)
  (unless *livedoor-reader-notifier-quiet*
    (message msg)))


;;;; startup hook

(defun livedoor-reader-notifier-start-update-timer ()
  (while (stop-timer 'livedoor-reader-notifier-update-unread))
  (let ((dt (livedoor-reader-notifier-update-interval-sec)))
    (when (and dt (< 0 dt))
      (livedoor-reader-notifier-update-unread)
      ;; *livedoor-reader-notifier-update-interval* がすぐに反映されるように
      ;; one-shot で実行する。
      (start-timer dt 'livedoor-reader-notifier-start-update-timer t))))

;;; とりあえずメニューを追加しておく
(add-hook '*init-app-menus-hook* 'livedoor-reader-notifier-update-menu)

;;; *post-startup-hook* の中で *livedoor-reader-notifier-user* とかを
;;; 設定しているかもしれないので、完全に起動してから実行するようにする
(defvar *livedoor-reader-notifier-startup-delay* 5)
(add-hook '*post-startup-hook*
          #'(lambda ()
              (start-timer *livedoor-reader-notifier-startup-delay*
                           'livedoor-reader-notifier-start-update-timer t)))


(provide "livedoor-reader-notifier")


;;;; End
