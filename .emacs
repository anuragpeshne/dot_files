(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)

(require 'evil)
(evil-mode 1)

;; search with regex
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)

(autoload 'php-mode "php-mode" "Major mode for editing php code." t)
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.inc$" . php-mode))

(define-key evil-normal-state-map "M-x" 'execute-extended-command)
(load-theme 'wombat t)

(global-hl-line-mode 1)
(set-face-attribute hl-line-face nil :underline nil)
(linum-mode 1)
(line-number-mode 1)
(global-linum-mode t)
(column-number-mode 1)
(global-font-lock-mode t)
(show-paren-mode 1)
(prefer-coding-system 'utf-8)

(setq case-fold-search t
      search-highlight t
      query-replace-highlight t
      fill-column 80
      c-tab-always-indent "other"
      make-backup-files nil
      ispell-dictionary "english"
      standard-indent 4
      transient-mark-mode t
      visible-bell t
      show-paren-delay 0)
(delete-selection-mode 1)

;; nice parentheses
(show-paren-mode t)
(setq show-paren-style 'expression)

;; use a nice font by default
(set-frame-font "-apple-Monaco-medium-normal-normal-*-14-*-*-*-m-0-fontset-auto1")

(scroll-bar-mode -1)
(add-hook 'after-init-hook #'global-flycheck-mode)

;; Personal Info
(setq user-mail-address "anurag.peshne@gmail.com")
(setq user-full-name "Anurag Peshne")

(setq-default show-trailing-whitespace t)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; start maximized
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" "26614652a4b3515b4bbbb9828d71e206cc249b67c9142c06239ed3418eff95e2" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "e16a771a13a202ee6e276d06098bc77f008b73bbac4d526f160faa2d76c1dd0e" default)))
 '(initial-frame-alist (quote ((fullscreen . maximized))))
 '(php-manual-path "/Users/anuragpeshne/Documents/"))

(define-key global-map (kbd "RET") 'newline-and-indent)

;; Change cursor color depending on mode
(setq evil-emacs-state-cursor '("red" box))
(setq evil-normal-state-cursor '("green" box))
(setq evil-visual-state-cursor '("orange" box))
(setq evil-insert-state-cursor '("red" bar))
(setq evil-replace-state-cursor '("red" bar))
(setq evil-operator-state-cursor '("red" hollow))

;; powerline
(setq sml/theme 'powerline)
(sml/setup)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
