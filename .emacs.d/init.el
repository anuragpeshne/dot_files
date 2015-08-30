(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)
(when (not package-archive-contents) (package-refresh-contents))

;; search with regex
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)

;; current line and line number
;; (global-hl-line-mode 1)
;; (set-face-attribute hl-line-face nil :underline nil)
(linum-mode 1)
(line-number-mode 1)
(global-linum-mode t)
(column-number-mode 1)
(require 'linum-relative)

;; look
(load-theme 'wombat t)
(global-font-lock-mode t)
(show-paren-mode 1)
(prefer-coding-system 'utf-8)
;; use a nice font by default
(set-frame-font "-apple-Monaco-medium-normal-normal-*-12-*-*-*-m-0-fontset-auto1")
(require 'whitespace)
(setq whitespace-style '(face empty tabs lines-tail trailing))
(global-whitespace-mode t)
(setq-default indent-tabs-mode nil) ;; use space for indentation
(setq-default tab-width 2) ; or any other preferred value
(setq indent-line-function 'insert-tab)
(defvaralias 'c-basic-offset 'tab-width)
(defvaralias 'cperl-indent-level 'tab-width)
(display-time-mode 1)

(setq case-fold-search t
      search-highlight t
      query-replace-highlight t
      fill-column 80
      make-backup-files nil
      ispell-dictionary "english"
      transient-mark-mode t
      visible-bell t
      show-paren-delay 0)
(delete-selection-mode 1)

;; nice parentheses
(show-paren-mode t)
(setq show-paren-style 'expression)

(scroll-bar-mode -1)
(add-hook 'after-init-hook #'global-flycheck-mode)

;; Personal Info
(setq user-mail-address "anurag.peshne@gmail.com")
(setq user-full-name "Anurag Peshne")

;; take care of trailing whitespace
(setq-default show-trailing-whitespace t)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(define-key global-map (kbd "RET") 'newline-and-indent)

;; evil
(setq evil-want-C-u-scroll t)

;; Change cursor color depending on mode
(setq evil-emacs-state-cursor '("red" box))
(setq evil-normal-state-cursor '("green" box))
(setq evil-visual-state-cursor '("orange" box))
(setq evil-insert-state-cursor '("red" bar))
(setq evil-replace-state-cursor '("red" bar))
(setq evil-operator-state-cursor '("red" hollow))
(require 'evil)
(evil-mode 1)
(define-key evil-normal-state-map "M-x" 'execute-extended-command)

;;php mode:  do stuff only if php-mode installed
(when (require 'php-mode nil 'noerror)
  (autoload 'php-mode "php-mode" "Major mode for editing php code." t)
  (add-to-list 'auto-mode-alist '("\\.php$" . php-mode))
  (add-to-list 'auto-mode-alist '("\\.inc$" . php-mode))
)
;; powerline
(setq sml/theme 'dark)
(setq sml/no-confirm-load-theme t)
(sml/setup)

;; shell mode
(add-hook 'shell-mode-hook
          (lambda ()
            (linum-mode -1)
            (evil-mode -1)))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("26614652a4b3515b4bbbb9828d71e206cc249b67c9142c06239ed3418eff95e2" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
