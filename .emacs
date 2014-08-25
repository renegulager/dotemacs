;;;
;;; Org Mode
;;;
(add-to-list 'load-path (expand-file-name "~/Dropbox/bin/org-mode/lisp"))
(setq load-path (cons "~/Dropbox/bin/lisp" load-path))
(setq load-path (cons "~/Dropbox/bin/lisp/php-mode-1.5.0" load-path))
(setq load-path (cons "~/Dropbox/bin/org-mode/contrib/lisp" load-path))  ; Save directory
(load "da-kalender")


(add-to-list 'auto-mode-alist '("\\.\\(org\\|org_archive\\|txt\\)$" . org-mode))

(require 'org-install)
(require 'yasnippet-bundle)
;;
;; Standard key bindings
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
;; org mmobile

;; Set to the location of your Org files on your local system
(setq org-directory "~/Dropbox/org")
;; Set to the name of the file where new notes will be stored
(setq org-mobile-inbox-for-pull "~/Dropbox/org/flagged.org")
;; Set to <your Dropbox root directory>/MobileOrg.
(setq org-mobile-directory "~/Dropbox/MobileOrg")



;; Backup filer med versionerting 
(setq
   backup-by-copying t      ; don't clobber symlinks
   backup-directory-alist
    '(("." . "~/Dropbox/org/tmp"))    ; don't litter my fs tree
   delete-old-versions t
   kept-new-versions 6
   kept-old-versions 2
   version-control t) 

;; (setq message-mode-hook
;;      (quote (orgstruct++-mode
;;              (lambda nil (setq fill-column 100) (flyspell-mode 1))
;;              turn-on-auto-fill
;;              bbdb-define-all-aliases)))

 (add-hook 'mail-mode-hook 'turn-on-orgstruct)
'(org-refile-targets (quote ("~/Dropbox/org/notes.org"
			     "~/Dropbox/org/lister.org"
			     "~/Dropbox/org/todo.org"
			     "~/Dropbox/org/somedaymaby.org"
			     "~/Dropbox/org/journal.org")))


; Make TAB the yas trigger key in the org-mode-hook and enable flyspell mode and autofill
(add-hook 'org-mode-hook
          (lambda ()
            ;; yasnippet
            (make-variable-buffer-local 'yas/trigger-key)
            (org-set-local 'yas/trigger-key [tab])
            (define-key yas/keymap [tab] 'yas/next-field-group)
            ;; flyspell mode for spell checking everywhere
            (flyspell-mode 1)
            ;; auto-fill mode on
            (auto-fill-mode 1)))

(setq org-agenda-files (quote ("~/Dropbox/org"
                               )))



(global-set-key (kbd "<f12>") 'org-agenda)


(setq org-todo-keywords (quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d!/!)")
 (sequence "WAITING(w@/!)" "SOMEDAY(s!)" "|" "CANCELLED(c@/!)")
 (sequence "QUOTE(q!)" "QUOTED(Q!)" "|" "APPROVED(A@)" "EXPIRED(E@)" "REJECTED(R@)")
 (sequence "OPEN(O)" "|" "CLOSED(C)"))))

(setq org-todo-keyword-faces
      (quote (("TODO"      :foreground "red"          :weight bold)
              ("NEXT"      :foreground "blue"         :weight bold)
              ("DONE"      :foreground "forest green" :weight bold)
              ("WAITING"   :foreground "yellow"       :weight bold)
              ("SOMEDAY"   :foreground "goldenrod"    :weight bold)
              ("CANCELLED" :foreground "orangered"    :weight bold)
              ("QUOTE"     :foreground "hotpink"      :weight bold)
              ("QUOTED"    :foreground "indianred1"   :weight bold)
              ("APPROVED"  :foreground "forest green" :weight bold)
              ("EXPIRED"   :foreground "olivedrab1"   :weight bold)
              ("REJECTED"  :foreground "olivedrab"    :weight bold)
              ("OPEN"      :foreground "magenta"      :weight bold)
              ("CLOSED"    :foreground "forest green" :weight bold))))




(setq org-default-notes-file "~/Dropbox/org/refile.org")

;; I use C-M-r to start capture mode
(global-set-key (kbd "C-M-r") 'org-capture)
(global-set-key (kbd "<f11>") 'org-capture)

;; 3 capture templates for TODO tasks, Notes, and org-protocol (untested)
(setq org-capture-templates (quote (("t" "todo" entry (file "~/Dropbox/org/refile.org") "* TODO %?                      %t
  " )
     ("n" "note" entry (file "~/Dropbox/org/refile.org") "* %?               %t                                                             :NOTE:
  " )
		    ("p" "project" entry (file "~/Dropbox/org/refile.org") "* %?               %t                                        :project: 

")
                                    ("w" "org-protocol" entry (file "~/Dropbox/org/refile.org") "* TODO Review %c
  %U" :immediate-finish t :clock-in t :clock-resume t))))



;; diverse setups af local settings
(setq

  ;; don't show annoing startup msg
  inhibit-startup-message t
  ;; display time in the modeline
  display-time-24hr-format t
  display-time-day-and-date t
  ;; calendar customizing
  european-calendar-style t
  calendar-week-start-day 1
)
;; Show column number on the status line
(column-number-mode t)

;; Share the clipboard with X
(setq x-select-enable-clipboard t)

;; er vist ca en a4 side
(setq fill-column 100)
(setq-default fill-column 100)

;; TEXT configuration
;;

;; Brug ispell

;; Bruge dansk ordbog som standart
(setq ispell-dictionary "dansk")

;; Brug flyspell i TeX-mode
(add-hook 'TeX-mode-hook 'flyspell-mode)

;; Ispell i TeX-mode
(add-hook 'TeX-mode-hook (function(lambda()(setq ispell-parser'tex))))
(add-hook 'org-mode-hook (function(lambda()(setq ispell-parser'tex))))

(add-hook 'org-mode-hook 'flyspell-mode)


;;w3m browser med emacs, skal dog være installeret
;;apt-get w3m-el
(add-to-list 'load-path "/usr/share/emacs/site-lisp/w3m")
(if window-system
   (require 'w3m-load))


;;php mode
(autoload 'php-mode "php-mode" "Major mode for editing php code." t)
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.inc$" . php-mode))


;;Ditaa
 (setq org-ditaa-jar-path "~/Dropbox/bin/org-mode/contrib/scripts/ditaa.jar")
 (add-hook 'org-babel-after-execute-hook 'org-display-inline-images)
 (setq org-babel-load-languages (quote ((emacs-lisp . t)
                                        (dot . t)
                                        (ditaa . t)
                                        (R . t)
                                        (python . t)
                                        (ruby . t)
                                        (gnuplot . t)
                                        (clojure . t)
                                        (sh . t)
                                        (ledger . t)
                                        (org . t))))




(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files (quote ("/home/rgu/Dropbox/org/brew.org" "/home/rgu/Dropbox/org/cal.org" "/home/rgu/Dropbox/org/camino.org" "/home/rgu/Dropbox/org/flagged.org" "/home/rgu/Dropbox/org/journal.org" "/home/rgu/Dropbox/org/kurser.org" "/home/rgu/Dropbox/org/mette.org" "/home/rgu/Dropbox/org/mobileorg.org" "/home/rgu/Dropbox/org/onsker.org" "/home/rgu/Dropbox/org/opskrifter.org" "/home/rgu/Dropbox/org/passwd.org" "/home/rgu/Dropbox/org/refile.org" "/home/rgu/Dropbox/org/rss.org" "/home/rgu/Dropbox/org/security.org" "/home/rgu/Dropbox/org/somedaymaby.org" "/home/rgu/Dropbox/org/todo.org" "/home/rgu/Dropbox/org/traning.org" "/home/rgu/Dropbox/org/typo3conf2013.org" "/home/rgu/Dropbox/org/uddandelse.org" "/home/rgu/Dropbox/org/uv-jagt.org"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
