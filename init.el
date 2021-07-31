;(setq debug-on-error t)
(setq inhibit-startup-message t)

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))

(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))


; (setq indo-enable-flex-matching t)
; (setq ido-everywhere t)
; (ido-mode 1)

;///////////////////////////////////////////////////////////
;///////////////    SETTINGS      //////////////////////////
;///////////////////////////////////////////////////////////

(linum-mode 1)
; prevent auto backup
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

; todo set auto pair doesn't work in emacs-lisp
;(sp-local-pair 'emacs-lisp-mode "'" nil :actions nil)
;(sp-local-pair 'lisp-interaction-mode "'" nil :actions nil)
; 也可以把上面两句合起来
;(sp-local-pair '(emacs-lisp-mode lisp-interaction-mode) "'" nil :actions nil)
;; (sp-local-pair 'emacs-lisp-mode "`" nil :actions nil)


;`````````````````````````` ``````````````````````````````````````
;`````````````````````````` DIRED-MODE````````````````````````````
;`````````````````````````` ``````````````````````````````````````
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










;-----------------------------------------------------------
;/////////////////////    EVIL /////////////////////////////
;-----------------------------------------------------------

(use-package evil-leader
  :ensure t
  :init (global-evil-leader-mode)
  :config
  (progn
    (evil-leader/set-key

      ;```````````````````````````` Files
      "ff" 'helm-find-files
      "fj" 'dired-jump
      "fs" 'save-buffer
      "pd" 'helm-projectile-find-dir
      "fas" 'fasd-find-file

      ;```````````````````````````` Strings
      "sp" 'helm-project-smart-do-search

      ;```````````````````````````` Buffers
      "bb" 'switch-to-buffer
      "bl" 'list-buffers
      "bp" 'previous-buffer
      "bn" 'next-buffer
      "bk" 'kill-buffer
      "TAB" 'alternate-buffer
      ;; helm-projectile-recentf

      ;```````````````````````````` Windows
      "0"  'select-window-0
      "1"  'select-window-1
      "2"  'select-window-2
      "3"  'select-window-3
      "4"  'select-window-4
      "w/" 'split-window-right
      "ws" 'split-window-below
      "wd" 'delete-window
      "wm" 'delete-other-windows

      ;```````````````````````````` Settings
      "SPC" 'counsel-M-x
      ";" 'evilnc-comment-or-uncomment-lines
      "cp" 'evilnc-comment-or-uncomment-paragraphs

      "qq" 'save-buffers-kill-terminal
      "qR" 'restart-emacs

      ;```````````````````````````` Tools
      "ms" 'youdao-dictionary-search-at-point-tooltip
      "mc" 'helm-show-kill-ring
      )
    ))


(evil-mode 1)
(setq evil-shift-width 2)
(setcdr evil-insert-state-map nil)
(define-key evil-insert-state-map [escape] 'evil-normal-state)
(delete-selection-mode 1)
;; normal-state 下 RET 键打开最近的 buffer 列表
;; (define-key evil-normal-state-map (kbd "<RET>") 'helm-mini)
(define-key evil-normal-state-map (kbd "<RET>") 'helm-projectile-find-file)


;^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
;/////////////////////    CUSTOM FUNC   ////////////////////
;^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
; 使用下面的代码则可以定义函数将此换行符删除，
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


; If you like a tabbar
; (use-package tabbar
;  :ensure t
;  :config
;  (tabbar-mode 1))


;--------------------------- packages --------------------------------
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

(use-package ace-window
  :ensure t
  :init
  (progn
    (global-set-key [remap other-window] 'ace-window)
    (custom-set-faces
    '(aw-leading-char-face
       ;; set tip-font size
       ((t (:inherit ace-jump-face-foreground :height 2.0)))))
    ))

(use-package window-numbering
  :ensure t
  :init (window-numbering-mode 1)
  :config
  (setq window-numbering-assign-func
      (lambda () (when (equal (buffer-name) "*Calculator*") 9))))

(use-package evil-surround
  :ensure t
  :init (global-evil-surround-mode 1))

(use-package evil-nerd-commenter
  :ensure t
  :config
  (evilnc-default-hotkeys)
  (define-key evil-normal-state-map (kbd ",/") 'evilnc-comment-or-uncomment-lines)
  (define-key evil-visual-state-map (kbd ",/") 'evilnc-comment-or-uncomment-lines)
  )

(use-package better-defaults
  :ensure t
  )

(use-package restart-emacs
    :ensure t
    )

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
  :ensure t
  :bind ("C-c C-j" . avy-goto-char))

;(use-package dired-x
;  :ensure t
;  )

(use-package iedit
  :ensure t
  )

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
  (smartparens-global-mode t)
  )

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
  )

; (use-package auto-complete
;   :ensure t
;   :config
;   (ac-config-default))


; todo , this is not work
(use-package helm-ag
  :ensure t
  :config
  ;; :bind ("C-c p f" . helm-do-ag-project-root)
  )

(use-package helm-projectile
  :ensure t
  :config
  (helm-projectile-on))


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
  :ensure t
  )

(use-package symbol-overlay
  :ensure t
  :config
  :bind ("M-i" . symbol-overlay-put)
  :bind ("M-n" . symbol-overlay-jump-next)
  :bind ("M-p" . symbol-overlay-jump-prev)
  :bind ("<F8>" . symbol-overlay-remove-all)
  )

(use-package fasd
    :ensure t
    :init (global-fasd-mode 1))

(use-package diff-hl
  :ensure t
  :config
  (global-diff-hl-mode 1)
  (add-hook 'magit-pre-refresh-hook 'diff-hl-magit-pre-refresh)
  (add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh))


(use-package powerline
  :ensure t
  :config
  (powerline-default-theme)
  )

(use-package magit
  :ensure t
  )




;*************************************************************
;*********************  FUN  *********************************
;*************************************************************
(use-package nyan-mode
  :ensure t
  :config (nyan-mode 1))

(require 'zone)
(zone-when-idle 600)





;/////////////////////////////////////////////////////////////
;///////////////////////     JS      /////////////////////////
;/////////////////////////////////////////////////////////////
(use-package web-mode
  :ensure t
  :config
  (setq web-mode-markup-indent-offset 2) ; web-mode, html tag in html file
  (setq web-mode-css-indent-offset 2)    ; web-mode, css in html file
  (setq web-mode-code-indent-offset 2)   ; web-mode, js code in html file
  (setq auto-mode-alist
	(append
	 '(("\\.js\\'" . js2-mode))
	 '(("\\.html\\'" . web-mode))
	 auto-mode-alist)))















; todo , set indent to 2 spc
(use-package js2-mode
  :ensure t
  :config
;  (setq js2-mode-hook
;	(setq-default indent-tabs-mode nil)
        )







