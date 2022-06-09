;;(setq debug-on-error t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(evil-leader/leader "SPC")
 '(evil-want-C-u-scroll t)
 '(js2-missing-semi-one-line-override t)
 '(js2-mode-show-parse-errors t)
 '(js2-mode-show-strict-warnings t)
 '(js2-strict-missing-semi-warning nil)
 '(package-selected-packages
   '(magit diff-hl better-defaults helm-rg youdao-dictionary evil-surround window-numbering window-numbering-mode yasnippet flycheck helm-ag iedit expand-region web-mode highlight-parentheses dired-x popwin company js2-mode smartparens hungry-delete evil-leader counsel swiper ace-window which-key 0blayout use-package try)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(aw-leading-char-face ((t (:inherit ace-jump-face-foreground :height 2.0)))))




(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))

(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))


;; (setq indo-enable-flex-matching t)
;; (setq ido-everywhere t)
;; (ido-mode 1)
;;///////////////////////////////////////////////////////////
;;///////////////    SETTINGS      //////////////////////////
;;///////////////////////////////////////////////////////////
(custom-set-faces
 '(default ((t (:height 150 :family "Hermit"))))
 )

(setq inhibit-startup-message t)

(setq custom-tab-width 2)

;; (defun disable-tabs () (setq indent-tabs-mode nil))
;; (defun enable-tabs ()
;;   (local-set-key (kbd "TAB") 'tab-to-tab-stop)
;;   (setq indent-tabs-mode t)
;;   (setq tab-width custom-tab-width))

;; (setq initial-buffer-choice "~/.emacs.d/recentf")
(fringe-mode 0)
(global-linum-mode 1)
(setq linum-format " %d ")
;; prevent auto backup
(setq make-backup-files nil)

(global-hl-line-mode 1)

(setq auto-save-default nil)

(setq ring-bell-function 'ignore)

(fset 'yes-or-no-p 'y-or-n-p)

;; (defalias 'list-buffers 'ibuffer)
(defalias 'list-buffers 'ibuffer-other-window)

;; When you want to delete a directorys, you don't need to select delete-mode
(setq dired-recursive-deletes 'always)
(setq dired-recursive-copies 'always)

(global-set-key (kbd "C-w") 'backward-kill-word)

;; todo set auto pair doesn't work in emacs-lisp
;;(sp-local-pair 'emacs-lisp-mode "'" nil :actions nil)
;;(sp-local-pair 'lisp-interaction-mode "'" nil :actions nil)
;; 也可以把上面两句合起来
;; (sp-local-pair '(emacs-lisp-mode lisp-interaction-mode) "'" nil :actions nil)
;; (sp-local-pair 'emacs-lisp-mode "`" nil :actions nil)

;;`````````````````````````` ``````````````````````````````````````
;;`````````````````````````` DIRED-MODE````````````````````````````
;;`````````````````````````` ``````````````````````````````````````
(put 'dired-find-alternate-file 'disabled nil)
(global-set-key (kbd "s-b") 'dired-up-directory)
;; 主动加载 Dired Mode
;; (require 'dired)
;; (defined-key dired-mode-map (kbd "RET") 'dired-find-alternate-file)
;; 延迟加载
(with-eval-after-load 'dired
  (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file))

(setq dired-dwin-target 1)

;; dired-mode 批量操作
;; 进入 dired-mode , C-x C-q 进入编辑模式, C-= select region










;;-----------------------------------------------------------
;;/////////////////////    EVIL  ////////////////////////////
;;-----------------------------------------------------------

(use-package evil-leader
  :ensure t
  :config
  (global-evil-leader-mode)
  (progn
    (evil-leader/set-key

      ;; spacemacs
      ;;```````````````````````````` Files
      "fed" 'open-emacs-dotfile
      "ff" 'helm-find-files
      "fj" 'dired-jump
      "fs" 'save-buffer
      "fo" 'xah-open-in-external-app
      "pd" 'helm-projectile-find-dir
      "fas" 'fasd-find-file

      ;;```````````````````````````` Strings
      "sp" 'counsel-git-grep
      "sl" 'helm-semantic-or-imenu
      ;; "sp" 'helm-projectile-grep


      ;;```````````````````````````` Buffers
      "bb" 'switch-to-buffer
      "bl" 'list-buffers
      "bp" 'previous-buffer
      "bn" 'next-buffer
      "bk" 'kill-buffer
      "TAB" 'alternate-buffer
      ;; helm-projectile-recentf

      ;;```````````````````````````` Windows
      "0"  'select-window-0
      "1"  'select-window-1
      "2"  'select-window-2
      "3"  'select-window-3
      "4"  'select-window-4
      "w/" 'split-window-right
      "ws" 'split-window-below
      "wd" 'delete-window
      "wm" 'delete-other-windows

      ;;```````````````````````````` Settings
      "SPC" 'counsel-M-x
      ";" 'evilnc-comment-or-uncomment-lines
      "cp" 'evilnc-comment-or-uncomment-paragraphs
      "=" 'er-indent-region-or-buffer
      "qq" 'save-buffers-kill-terminal
      "qr" 'restart-emacs

      ;;```````````````````````````` Tools
      "op" 'youdao-dictionary-search-at-point-tooltip
      "mc" 'helm-show-kill-ring

      "jj" 'avy-goto-char
      )
    ))
(evil-mode 1)
(setq evil-shift-width 2)
(setcdr evil-insert-state-map nil)
(define-key evil-insert-state-map [escape] 'evil-normal-state)
(delete-selection-mode 1)


;;^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
;;/////////////////////    CUSTOM FUNC   ////////////////////
;;^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
;; ---------------- copy word ---------------
(use-package edit-at-point
  :ensure t)

(defun mzy/edit-at-point-cut-word ()
  (interactive)
  (edit-at-point-word-cut)
  (evil-insert 1)
  )
(defun mzy/evil-ex-s ()
  (interactive)
  (evil-ex "'<,'>s/")
  )

(defun mzy/evil-ex-%s ()
  (interactive)
  (evil-ex "%s/")
  )

(define-key evil-normal-state-map (kbd "; a a") 'edit-at-point-word-copy)
(define-key evil-normal-state-map (kbd "; c c") 'mzy/edit-at-point-cut-word)
(define-key evil-normal-state-map (kbd "; s c") 'edit-at-point-word-cut)
(define-key evil-normal-state-map (kbd "; s r") 'mzy/evil-ex-s)
(define-key evil-normal-state-map (kbd "; r r") 'mzy/evil-ex-%s)
(define-key evil-normal-state-map (kbd "; s p") 'edit-at-point-word-paste)
(define-key evil-normal-state-map (kbd "; s d") 'edit-at-point-word-delete)

(define-key evil-visual-state-map (kbd "v") 'er/expand-region)
(define-key evil-visual-state-map (kbd "V") 'er/contract-region)

;; ---------------- copy word ---------------


;; 使用下面的代码则可以定义函数将此换行符删除，
(defun remove-dos-eol ()
  "Replace DOS eolns CR LF with Unix eolns CR"
  (interactive)
  (goto-char (point-min))
  (while (search-forward "\r" nil t) (replace-match "")))

(defun hidden-dos-eol ()
  "Do not show ^M in files containing mixed UNIX and DOS line endings."
  (interactive)
  (unless buffer-display-table
    (setq buffer-display-table (make-display-table)))
  (aset buffer-display-table ?\^M []))


(defun my-web-mode-indent-setup ()
  (setq web-mode-markup-indent-offset 2) ; web-mode, html tag in html file
  (setq web-mode-css-indent-offset 2)    ; web-mode, css in html file
  (setq web-mode-code-indent-offset 2)   ; web-mode, js code in html file
  )
(add-hook 'web-mode-hook 'my-web-mode-indent-setup)
(defun my-toggle-web-indent ()
  (interactive)
  ;; web development
  (if (or (eq major-mode 'js-mode) (eq major-mode 'js2-mode))
      (progn
        (setq js-indent-level (if (= js-indent-level 2) 4 2))
        (setq js2-basic-offset (if (= js2-basic-offset 2) 4 2))))

  (if (eq major-mode 'web-mode)
      (progn (setq web-mode-markup-indent-offset (if (= web-mode-markup-indent-offset 2) 4 2))
             (setq web-mode-css-indent-offset (if (= web-mode-css-indent-offset 2) 4 2))
             (setq web-mode-code-indent-offset (if (= web-mode-code-indent-offset 2) 4 2))))
  (if (eq major-mode 'css-mode)
      (setq css-indent-offset (if (= css-indent-offset 2) 4 2)))

  (setq indent-tabs-mode nil))

(global-set-key (kbd "C-c t i") 'my-toggle-web-indent)

(defun occur-dwim ()
  "Call `occur' with a sane default."
  (interactive)
  (push (if (region-active-p)
            (buffer-substring-no-properties
             (region-beginning)
             (region-end))
          (let ((sym (thing-at-point 'symbol)))
            (when (stringp sym)
              (regexp-quote sym))))
        regexp-history)
  (call-interactively 'occur))
(global-set-key (kbd "M-s o") 'occur-dwim)

(defun js2-imenu-make-index ()
  (interactive)
  (save-excursion
    ;; (setq imenu-generic-expression '((nil "describe\\(\"\\(.+\\)\"" 1)))
    (imenu--generic-function '(("describe" "\\s-*describe\\s-*(\\s-*[\"']\\(.+\\)[\"']\\s-*,.*" 1)
                               ("it" "\\s-*it\\s-*(\\s-*[\"']\\(.+\\)[\"']\\s-*,.*" 1)
                               ("test" "\\s-*test\\s-*(\\s-*[\"']\\(.+\\)[\"']\\s-*,.*" 1)
                               ("before" "\\s-*before\\s-*(\\s-*[\"']\\(.+\\)[\"']\\s-*,.*" 1)
                               ("after" "\\s-*after\\s-*(\\s-*[\"']\\(.+\\)[\"']\\s-*,.*" 1)
                               ("Function" "function[ \t]+\\([a-zA-Z0-9_$.]+\\)[ \t]*(" 1)
                               ("Function" "^[ \t]*\\([a-zA-Z0-9_$.]+\\)[ \t]*=[ \t]*function[ \t]*(" 1)
                               ("Function" "^var[ \t]*\\([a-zA-Z0-9_$.]+\\)[ \t]*=[ \t]*function[ \t]*(" 1)
                               ("Function" "^[ \t]*\\([a-zA-Z0-9_$.]+\\)[ \t]*()[ \t]*{" 1)
                               ("Function" "^[ \t]*\\([a-zA-Z0-9_$.]+\\)[ \t]*:[ \t]*function[ \t]*(" 1)
                               ("Task" "[. \t]task([ \t]*['\"]\\([^'\"]+\\)" 1)))))
(add-hook 'js2-mode-hook
          (lambda ()
            (setq imenu-create-index-function 'js2-imenu-make-index)))

(global-set-key (kbd "M-s i") 'counsel-imenu)


(defun alternate-buffer ()
  (interactive)
  (switch-to-buffer (other-buffer)))

(defun open-emacs-dotfile()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

(defun er-indent-buffer ()
  "Indent the currently visited buffer."
  (interactive)
  (indent-region (point-min) (point-max)))

(defun er-indent-region-or-buffer ()
  "Indent a region if selected, otherwise the whole buffer."
  (interactive)
  (save-excursion
    (if (region-active-p)
        (progn
          (indent-region (region-beginning) (region-end))
          (message "Indented selected region."))
      (progn
        (er-indent-buffer)
        (message "Indented buffer.")))))

(defun xah-open-in-external-app (&optional file)
  "Open the current file or dired marked files in external app.

The app is chosen from your OS's preference."
  (interactive)
  (let ( doIt
         (myFileList
          (cond
           ((string-equal major-mode "dired-mode") (dired-get-marked-files))
           ((not file) (list (buffer-file-name)))
           (file (list file)))))

    (setq doIt (if (<= (length myFileList) 5)
                   t
                 (y-or-n-p "Open more than 5 files? ") ) )

    (when doIt
      (cond
       ((string-equal system-type "windows-nt")
        (mapc (lambda (fPath) (w32-shell-execute "open" (replace-regexp-in-string "/" "\\" fPath t t)) ) myFileList))
       ((string-equal system-type "darwin")
        (mapc (lambda (fPath) (shell-command (format "open \"%s\"" fPath)) )  myFileList) )
       ((string-equal system-type "gnu/linux")
        (mapc (lambda (fPath) (let ((process-connection-type nil)) (start-process "" nil "xdg-open" fPath))) myFileList) ) ) ) ) )

;; If you like a tabbar
;; (use-package tabbar
;;  :ensure t
;;  :config
;;  (tabbar-mode 1))


;; --------------------------- packages --------------------------------
(use-package which-key
  :ensure t
  :config (which-key-mode))

(use-package try
  :ensure t)

(use-package popwin
  :ensure t
  :config
  (popwin-mode 1))

;; org-mode stuff
(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook #'org-bullets-mode))

;; (use-package ace-window
;;   :ensure t
;;   :init
;;   (progn
;;     (global-set-key [remap other-window] 'ace-window)
;;     (custom-set-faces
;;      '(aw-leading-char-face
;;        ;; set tip-font size
;;        ((t (:inherit ace-jump-face-foreground :height 2.0)))))
;;     ))

(use-package window-numbering
  :ensure t
  :init (window-numbering-mode 1)
  :config
  (setq window-numbering-assign-func
        (lambda () (when (equal (buffer-name) "*Calculator*") 9))))

(use-package whitespace-cleanup-mode
  :ensure t
  :config
  (global-whitespace-cleanup-mode)
  ;; (add-hook 'before-save-hook 'delete-trailing-whitespace)
  ;; (add-hook 'before-save-hook 'whitespace-cleanup)
  ;; :bind ("<f9>" . whitespace-newline-mode)
  )


;; auto delete the blank between the line
(add-hook 'before-save-hook 'delete-blank-lines)

(use-package evil-surround
  :ensure t
  :init (global-evil-surround-mode 1))

(use-package evil-nerd-commenter
  :ensure t
  :config
  (evilnc-default-hotkeys)
  (define-key evil-normal-state-map (kbd ",/") 'evilnc-comment-or-uncomment-lines)
  (define-key evil-visual-state-map (kbd ",/") 'evilnc-comment-or-uncomment-lines))

(use-package better-defaults
  :ensure t)

(use-package restart-emacs
  :ensure t)

(use-package counsel
  :ensure t)

(use-package swiper
  :ensure t
  :config
  (progn
    (ivy-mode)
    (setq ivy-use-virtual-buffers t)
    (setq enable-recursive-minibuffers t)
    ;; enable this if you want `swiper' to use it
    ;; (setq search-default-mode #'char-fold-to-regexp)
    (global-set-key "\C-s" 'swiper)
    (global-set-key (kbd "C-c C-r") 'ivy-resume)
    (global-set-key (kbd "<f6>") 'ivy-resume)
    (global-set-key (kbd "M-x") 'counsel-M-x)
    (global-set-key (kbd "C-x C-f") 'counsel-find-file)
    (global-set-key (kbd "<f1> f") 'counsel-describe-function)
    (global-set-key (kbd "<f1> v") 'counsel-describe-variable)
    (global-set-key (kbd "<f1> o") 'counsel-describe-symbol)
    (global-set-key (kbd "<f1> l") 'counsel-find-library)
    (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
    (global-set-key (kbd "<f2> u") 'counsel-unicode-char)
    (global-set-key (kbd "C-c g") 'counsel-git)
    (global-set-key (kbd "C-c j") 'counsel-git-grep)
    (global-set-key (kbd "C-c k") 'counsel-ag)
    (global-set-key (kbd "C-x l") 'counsel-locate)
    (global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
    (define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)
    ))


(use-package avy
  :ensure t)

;; (use-package dired-x
;; :ensure t
;; )

(use-package iedit
  :ensure t)

(use-package recentf
  :ensure t
  :config
  (recentf-mode 1)
  (setq recentf-max-menu-item 20))

(use-package hungry-delete
  :ensure t
  :config
  (global-hungry-delete-mode 1)
  (setq hungry-delete-join-reluctantly nil))

(use-package expand-region
  :ensure t
  :config
  :bind ("C-=" . 'er/expand-region))

(use-package smartparens
  :ensure t
  :config
  (smartparens-global-mode t))

(use-package highlight-parentheses
  :ensure t
  :config
  (global-highlight-parentheses-mode t))


(use-package company
  :ensure t
  :config
  (global-company-mode t)
  (setq company-prefix 1)
  (setq company-idle-delay 0.1)
  (setq company-minimum-prefix-length 1)
  :bind
  (:map company-active-map
        ([tab] . smarter-yas-expand-next-field-complete)
        ("TAB" . smarter-yas-expand-next-field-complete))
  )

(use-package auto-complete
  :ensure t
  :config
  (ac-config-default)
  (setq ac-auto-show-menu 0.02)
  (setq ac-use-menu-map t)
  (define-key ac-menu-map "C-n" 'ac-next)
  (define-key ac-menu-map "C-p" 'ac-previous)
  )

;; todo , this is not work
(use-package helm-ag
  :ensure t
  :config
  ;; :bind ("C-c p f" . helm-do-ag-project-root)
  ;; normal-state 下 RET 键打开最近的 buffer 列表
  ;; (define-key evil-normal-state-map (kbd "<RET>") 'helm-mini)
  (define-key evil-normal-state-map (kbd "<RET>") 'helm-projectile-find-file)
  )


(use-package helm-projectile
  :ensure t
  :config
  (helm-projectile-on))

(use-package helm-swoop
  :ensure t
  :bind ("C-c C-j" . helm-swoop))


(use-package flycheck
  :ensure t
  :config
  (add-hook 'js2-mode-hook 'flycheck-mode))

(use-package yasnippet
  :ensure t
  :config
  (add-to-list 'load-path
               "~/.emacs.d/yasnippet")
  (yas-global-mode 1))

(use-package youdao-dictionary
  :ensure t)

(use-package symbol-overlay
  :ensure t
  :config
  :bind ("M-i" . symbol-overlay-put)
  :bind ("M-n" . symbol-overlay-jump-next)
  :bind ("M-p" . symbol-overlay-jump-prev)
  :bind ("<f8>" . symbol-overlay-remove-all))

(use-package fasd
  :ensure t
  :init (global-fasd-mode 1))

(use-package diff-hl
  :ensure t
  :config
  (global-diff-hl-mode 1)
  (add-hook 'magit-pre-refresh-hook 'diff-hl-magit-pre-refresh)
  (add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh))

;; (global-git-gutter-mode +1)
;; (custom-set-variables
;;  '(git-gutter:window-width 2)
;;  '(git-gutter:modified-sign "♣ ")
;;  '(git-gutter:added-sign "♦ ")
;;  '(git-gutter:deleted-sign "✘ ")
;;  '(git-gutter:lighter "GG")
;;  )
;; ;; (set-face-background 'git-gutter:modified "yellow") ;; background color
;; (set-face-foreground 'git-gutter:modified "yellow")
;; (set-face-foreground 'git-gutter:added "green")
;; (set-face-foreground 'git-gutter:deleted "red")


(use-package mwim
  :ensure t
  :bind ("C-a" . mwim-beginning)
  :bind ("C-e" . mwim-end))

(use-package powerline
  :ensure t
  :config
  (powerline-default-theme))

(use-package magit
  :ensure t)
;;************************************
;;*********************  FUN  *********************************
;;*************************************************************
(use-package nyan-mode
  :ensure t
  :config (nyan-mode 1))

(require 'zone)
(zone-when-idle 600)






;;/////////////////////////////////////////////////////////////
;;///////////////////////     JS      /////////////////////////
;;/////////////////////////////////////////////////////////////

;; (require 'rainbow-mode)

(use-package web-mode
  :ensure t
  :config
  ;; (add-hook 'css-mode-hook 'rainbow-mode)
  (setq web-mode-markup-indent-offset 2) ; web-mode, html tag in html file
  (setq web-mode-css-indent-offset 2)    ; web-mode, css in html file
  (setq web-mode-code-indent-offset 2)   ; web-mode, js code in html file
  (setq auto-mode-alist
        (append
         '(("\\.js\\'" . js2-mode))
         '(("\\.html\\'" . web-mode))
         '(("\\.wxml\\'" . web-mode))
         '(("\\.css\\'" . scss-mode))
         auto-mode-alist)))

(use-package scss-mode
  :ensure t
  :config
  (setq css-indent-offset 2)
  (add-hook 'css-mode-hook
            '(lambda()
               (setq tab-width 4)))
  )

(use-package vue-mode
  :ensure t
  )

(use-package tern
  :ensure t
  :config
  (add-hook 'js-mode-hook (lambda () (tern-mode t)))
  )

(use-package emmet-mode
  :ensure t
  :config
  (add-hook 'html-mode-hook 'emmet-mode)
  (add-hook 'web-mode-hook 'emmet-mode)
  (add-hook 'css-mode-hook 'emmet-mode))

(use-package js2-refactor
  :ensure t
  :config
  (add-hook 'js2-mode-hook #'js2-refactor-mode)
  )

;; todo , set indent to 2 spc
(use-package js2-mode
  :ensure t
  :config
  (setq js2-basic-offset 2)
  (setq-default js-indent-level 2)
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
  ;; Better imenu
  (add-hook 'js2-mode-hook #'js2-imenu-extras-mode)
  ;;  (setq js2-mode-hook
  ;;	(setq-default indent-tabs-mode nil)
  )

(use-package xref-js2
  :ensure t
  :config
  (define-key js2-mode-map (kbd "M-.") nil)
  (js2r-add-keybindings-with-prefix "C-c C-r")
  (define-key js2-mode-map (kbd "C-k") #'js2r-kill)
  (add-hook 'js2-mode-hook (lambda ()
                             (add-hook 'xref-backend-functions #'xref-js2-xref-backend nil t))))

(use-package evil-escape
  :ensure t
  :config
  (setq-default evil-escape-delay 0.3)
  (setq evil-escape-excluded-major-modes '(dired-mode))
  (setq-default evil-escape-key-sequence "kj")
  (evil-escape-mode 1))

(use-package window-purpose
  :ensure t
  :config)
