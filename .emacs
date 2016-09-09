(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
;(global-linum-mode t)
(add-hook 'after-init-hook #'global-flycheck-mode)
(add-hook 'haskell-mode-hook (lambda () (setq evil-auto-indent nil)))
(add-hook 'haskell-mode-hook 'intero-mode)
;(when window-system (set-frame-size (selected-frame) 75 45))
(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
   'package-archives
   '("melpa" . "http://melpa.org/packages/")
   t)
  (package-initialize))
(require 'evil-leader)
(global-evil-leader-mode)
(evil-mode 1)
(evil-leader/set-leader "<SPC>")
(require 'evil)
(require 'nlinum-relative)
(nlinum-relative-setup-evil)                    ;; setup for evil
(add-hook 'prog-mode-hook 'nlinum-relative-mode)
(setq nlinum-relative-redisplay-delay 0)      ;; delay
(setq nlinum-relative-current-symbol "")      ;; or "" for display current line number
(setq nlinum-relative-offset 0)                 ;; 1 if you want 0, 2, 3...

;(require 'powerline)
;(powerline-default-theme)
;(require 'powerline-evil)

(evil-leader/set-key
    "," 'save-buffer
    "q" 'save-buffers-kill-terminal
    "n" 'evil-end-of-line
    "d" 'evil-beginning-of-line
    "u" 'intero-repl
    "c" 'intero-repl-load
    "N" 'flycheck-next-error
    "D" 'flycheck-previous-error
    ";" 'self-insert-command)


(define-key evil-normal-state-map "d" 'evil-backward-char)
(define-key evil-normal-state-map "h" 'evil-next-line)
(define-key evil-normal-state-map "t" 'evil-previous-line)
(define-key evil-normal-state-map "n" 'evil-forward-char)
(define-key evil-normal-state-map "e" 'evil-delete)
(define-key evil-normal-state-map "j" 'evil-forward-word-end)
(define-key evil-normal-state-map "K" 'evil-search-previous)
(define-key evil-normal-state-map "k" 'evil-search-next)
(define-key evil-normal-state-map "," 'evil-forward-word-begin)
(define-key evil-normal-state-map "w" 'evil-repeat-find-char-reverse)
(define-key evil-normal-state-map "l" 'evil-find-char-to)

(define-key evil-visual-state-map "d" 'evil-backward-char)
(define-key evil-visual-state-map "h" 'evil-next-line)
(define-key evil-visual-state-map "t" 'evil-previous-line)
(define-key evil-visual-state-map "n" 'evil-forward-char)
(define-key evil-visual-state-map "e" 'evil-delete)
(define-key evil-visual-state-map "j" 'evil-forward-word-end)
(define-key evil-visual-state-map "K" 'evil-search-previous)
(define-key evil-visual-state-map "k" 'evil-search-next)
(define-key evil-visual-state-map "," 'evil-forward-word-begin)
(define-key evil-visual-state-map "w" 'evil-repeat-find-char-reverse)
(define-key evil-visual-state-map "l" 'evil-find-char-to)

(define-key evil-operator-state-map "d" 'evil-backward-char)
(define-key evil-operator-state-map "h" 'evil-next-line)
(define-key evil-operator-state-map "t" 'evil-previous-line)
(define-key evil-operator-state-map "n" 'evil-forward-char)
(define-key evil-operator-state-map "e" 'evil-delete)
(define-key evil-operator-state-map "j" 'evil-forward-word-end)
(define-key evil-operator-state-map "K" 'evil-search-previous)
(define-key evil-operator-state-map "k" 'evil-search-next)
(define-key evil-operator-state-map "," 'evil-forward-word-begin)
(define-key evil-operator-state-map "w" 'evil-repeat-find-char-reverse)
(define-key evil-operator-state-map "l" 'evil-find-char-to)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (gruvbox)))
 '(custom-safe-themes
   (quote
    ("a164837cd2821475e1099911f356ed0d7bd730f13fa36907895f96a719e5ac3e" default)))
 '(inhibit-startup-screen t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(nlinum-relative-current-face ((t (:foreground "#7c6f64")))))
(setq backup-directory-alist
     `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
     `((".*" ,temporary-file-directory t)))
