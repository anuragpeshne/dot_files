;;; package --- Summary
;;; Commentary:
;; This is init Emacs of Anurag Peshne, This is how I roll.
;;; Code:

;; bump up garbage collection threshold; will restore this at the end
;; backup value
(defvar gc-cons-threshold-bk)
(setq gc-cons-threshold-bk gc-cons-threshold)
(setq gc-cons-threshold (* 100 1024 1024))

(setq user-full-name "Anurag Peshne"
      user-mail-address "anurag.peshne@gmail.com")

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
(when (not package-archive-contents) (package-refresh-contents))

;; are we on mac?
(defvar is-mac)
(setq is-mac (equal system-type 'darwin))

;; why say yes when y is enough
(fset 'yes-or-no-p 'y-or-n-p)

(setq use-package-verbose t)
;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(setq savehist-file "~/.emacs.d/savehist")
(savehist-mode 1)
(setq history-length t)
(setq history-delete-duplicates t)
(setq savehist-save-minibuffer-history 1)
(setq savehist-additional-variables
      '(kill-ring
        search-ring
        regexp-search-ring))

(when window-system
  (tooltip-mode -1)
  (tool-bar-mode -1)
  (menu-bar-mode 1)
  (scroll-bar-mode -1))

(use-package winner
             :ensure t
             :defer t)

(use-package auto-complete
             :ensure t
             :defer 3
             :diminish auto-complete-mode
             :init (ac-config-default))

(use-package flycheck
             :ensure t
             :defer 5
             :diminish flycheck-mode
             :init (global-flycheck-mode))

(use-package helm
             :ensure t
             :diminish helm-mode
             :init
             (progn
               (require 'helm-config)
               (setq helm-candidate-number-limit 100)
               ;; From https://gist.github.com/antifuchs/9238468
               (setq helm-idle-delay 0.0 ; update fast sources immediately (doesn't).
                     helm-input-idle-delay 0.01  ; this actually updates things
                                        ; reeeelatively quickly.
                     helm-yas-display-key-on-candidate t
                     helm-quick-update t
                     helm-M-x-requires-pattern nil
                     helm-ff-skip-boring-files t
                     helm-M-x-fuzzy-match t
                     helm-lisp-completion-at-point t
                     helm-autoresize-mode t)
               (helm-mode 1))
             :bind (("C-x C-f" . helm-find-files)
                    ("M-x" . helm-M-x)))

(use-package smart-mode-line
             :ensure t
             :defer t
             :init
             (progn
               (setq sml/theme 'dark)
               (setq sml/no-confirm-load-theme t)
               (sml/setup)))

(use-package smart-mode-line-powerline-theme
             :ensure t
             :defer t)

(use-package evil
             :ensure t
             :demand
             :init
             (progn
               (setq evil-want-C-u-scroll t)
               ;; Change cursor color depending on mode
               (setq evil-emacs-state-cursor '("red" box)
                     evil-normal-state-cursor '("green" box)
                     evil-visual-state-cursor '("orange" box)
                     evil-insert-state-cursor '("red" bar)
                     evil-replace-state-cursor '("red" bar)
                     evil-operator-state-cursor '("red" hollow))
               (evil-mode 1)))

(use-package magit :ensure t :defer 5)

;; highlight changes
(use-package git-gutter-fringe
  :ensure t
  ;:defer 5
  :diminish git-gutter-mode
  :config (global-git-gutter-mode))


(use-package zenburn-theme
  :ensure t
  :defer 2
  :init (load-theme 'zenburn t))

(use-package leuven-theme :ensure t :disabled t)

(use-package linum-relative
  :ensure t
  :defer t
  :init
  (progn
    (global-linum-mode t)
    (linum-relative-mode t)))

;; current line and line number
;; (linum-mode 1)
;; (line-number-mode 1)
;; (global-linum-mode t)
(column-number-mode 1)
(hl-line-mode 1)

;; look and appearance
(global-font-lock-mode t)
(show-paren-mode 1)
(prefer-coding-system 'utf-8)
;; use a nice font by default
(when is-mac
  (set-frame-font "-apple-Monaco-medium-normal-normal-*-12-*-*-*-m-0-fontset-auto1"))

(use-package whitespace
  :defer 2
  :init
  (progn
    (setq whitespace-style '(face empty tabs lines-tail trailing))
    (global-whitespace-mode t)))

(setq-default indent-tabs-mode nil) ;; use space for indentation
(setq-default tab-width 2) ;; or any other preferred value
(setq tab-stop-list (number-sequence 2 200 2))
(setq indent-line-function 'insert-tab)
(defvaralias 'c-basic-offset 'tab-width)
(defvaralias 'cperl-indent-level 'tab-width)

(setq case-fold-search t
      search-highlight t
      query-replace-highlight t
      fill-column 80
      make-backup-files nil
      ispell-dictionary "english"
      transient-mark-mode t
      show-paren-delay 0)
(delete-selection-mode 1)

;; good looking symbols
(defun my-add-pretty-lambda ()
"Make some word or string show as pretty Unicode symbols."
(setq prettify-symbols-alist
        '(
          ("lambda" . 955) ; λ
          ("->" . 8594)    ; →
          ("=>" . 8658)    ; ⇒
          ("map" . 8614)   ; ↦
          )))

(add-hook 'scheme-mode-hook 'my-add-pretty-lambda)
(add-hook 'tex-mode-hook 'my-add-pretty-lambda)

;; nice parentheses
(show-paren-mode t)
(setq show-paren-style 'expression)

;; take care of trailing whitespace
(setq-default show-trailing-whitespace t)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(define-key global-map (kbd "RET") 'newline-and-indent)

;;php mode
(use-package php-mode
  :mode ("\\.php$" "\\.inc$"))

;; shell mode
(add-hook 'shell-mode-hook
          (lambda ()
            (linum-mode -1)))

;; eshell mode
(add-hook 'eshell-mode-hook
          (lambda ()
            (linum-mode -1)))

;; faster buffer switch
(define-prefix-command 'vim-buffer-jump)
(global-set-key (kbd "C-w") 'vim-buffer-jump)
(define-key vim-buffer-jump (kbd "<left>") 'windmove-left)
(define-key vim-buffer-jump (kbd "<right>") 'windmove-right)
(define-key vim-buffer-jump (kbd "<up>") 'windmove-up)
(define-key vim-buffer-jump (kbd "<down>") 'windmove-down)

;; reload files automatically when changed on disk
(global-auto-revert-mode t)

(setq tramp-default-method "ssh")

(add-to-list 'auto-mode-alist '("\\.log\\'" . auto-revert-mode))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#3F3F3F" "#CC9393" "#7F9F7F" "#F0DFAF" "#8CD0D3" "#DC8CC3" "#93E0E3" "#DCDCCC"])
 '(custom-safe-themes
   (quote
    ("ff02e8e37c9cfd192d6a0cb29054777f5254c17b1bf42023ba52b65e4307b76a" "70b9c3d480948a3d007978b29e31d6ab9d7e259105d558c41f8b9532c13219aa" "20e359ef1818a838aff271a72f0f689f5551a27704bf1c9469a5c2657b417e6c" "f5eb916f6bd4e743206913e6f28051249de8ccfd070eae47b5bde31ee813d55f" "26614652a4b3515b4bbbb9828d71e206cc249b67c9142c06239ed3418eff95e2" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" default)))
 '(fci-rule-color "#383838")
 '(nrepl-message-colors
   (quote
    ("#CC9393" "#DFAF8F" "#F0DFAF" "#7F9F7F" "#BFEBBF" "#93E0E3" "#94BFF3" "#DC8CC3")))
 '(send-mail-function (quote mailclient-send-it))
 '(vc-annotate-background "#2B2B2B")
 '(vc-annotate-color-map
   (quote
    ((20 . "#BC8383")
     (40 . "#CC9393")
     (60 . "#DFAF8F")
     (80 . "#D0BF8F")
     (100 . "#E0CF9F")
     (120 . "#F0DFAF")
     (140 . "#5F7F5F")
     (160 . "#7F9F7F")
     (180 . "#8FB28F")
     (200 . "#9FC59F")
     (220 . "#AFD8AF")
     (240 . "#BFEBBF")
     (260 . "#93E0E3")
     (280 . "#6CA0A3")
     (300 . "#7CB8BB")
     (320 . "#8CD0D3")
     (340 . "#94BFF3")
     (360 . "#DC8CC3"))))
 '(vc-annotate-very-old-color "#DC8CC3"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;; custom language hooks
(add-hook 'javascript-mode-hook
          (function (lambda ()
                      (setq indent-tabs-mode nil
                            tab-width 2))))

;; org mode settings
(use-package org
  :defer t
  :bind
  (("\C-cl" . org-store-link)
   ("\C-ca" . org-agenda))
  :init
  (progn
    (setq org-log-done 'time)
    (setq org-src-fontify-natively t)
    (setq org-agenda-files (list "~/brainDump/projectStack.org"
                                 "~/brainDump/currentWeek.org"
                                 "~/brainDump/currentMonth.org"))))

(add-hook 'org-mode-hook
          (function (lambda ()
                      (ispell-minor-mode t))))

(set-frame-parameter nil 'fullscreen 'fullboth)
(setq inhibit-splash-screen t)
(org-agenda-list)
(delete-other-windows)
(setq ispell-program-name "/usr/local/bin/ispell")

(setq sql-mysql-program "/usr/local/mysql/bin/mysql")

;; Restore gc-cons-threshold
(setq gc-cons-threshold gc-cons-threshold-bk)

;;; init.el ends here
