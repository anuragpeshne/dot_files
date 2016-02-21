(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)
(when (not package-archive-contents) (package-refresh-contents))

;; are we on mac?
(setq is-mac (equal system-type 'darwin))

;; install plugins if they are missing
;; setup packages list
(setq package-list
      '(auto-complete
        flycheck
        helm
        php-mode
        powerline
        evil
        magit
        smart-mode-line-powerline-theme
        smart-mode-line
        zenburn-theme
        leuven-theme))

(mapc (lambda (package)
        (unless (package-installed-p package)
          (package-install package)))
      package-list)

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
(hl-line-mode 1)
(require 'linum-relative)
(linum-relative-mode 1)

;; look
(load-theme 'zenburn t)
(global-font-lock-mode t)
(show-paren-mode 1)
(prefer-coding-system 'utf-8)
;; use a nice font by default
(set-frame-font "-apple-Monaco-medium-normal-normal-*-12-*-*-*-m-0-fontset-auto1")
(require 'whitespace)
(setq whitespace-style '(face empty tabs lines-tail trailing))
(global-whitespace-mode t)
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
            (linum-mode -1)))

;; eshell mode
(add-hook 'eshell-mode-hook
          (lambda ()
            (linum-mode -1)))

;; auto complete config
(ac-config-default)

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

(require 'helm-config)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(setq helm-M-x-fuzzy-match t)
(setq helm-lisp-completion-at-point t)
(setq helm-autoresize-mode 1)
(helm-mode 1)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#3F3F3F" "#CC9393" "#7F9F7F" "#F0DFAF" "#8CD0D3" "#DC8CC3" "#93E0E3" "#DCDCCC"])
 '(custom-safe-themes
   (quote
    ("f5eb916f6bd4e743206913e6f28051249de8ccfd070eae47b5bde31ee813d55f" "26614652a4b3515b4bbbb9828d71e206cc249b67c9142c06239ed3418eff95e2" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" default)))
 '(fci-rule-color "#383838")
 '(nrepl-message-colors
   (quote
    ("#CC9393" "#DFAF8F" "#F0DFAF" "#7F9F7F" "#BFEBBF" "#93E0E3" "#94BFF3" "#DC8CC3")))
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
(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done 'time)
(setq org-src-fontify-natively t)
(setq org-completion-use-ido t)
(setq org-agenda-files (list "~/brainDump/projectStack.org"
                             "~/brainDump/currentWeek.org"))
(add-hook 'org-mode-hook
          (function (lambda ()
                      (load-theme 'leuven t)
                      (sml/apply-theme 'light-powerline))))

(set-frame-parameter nil 'fullscreen 'fullboth)
;;; init.el ends here
