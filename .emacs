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
(require 'smooth-scrolling)
(smooth-scrolling-mode 1)

(require 'powerline)
;(powerline-default-theme)
;(require 'powerline-evil)
(require 'airline-themes)
(require 'cl)
(setq-default custom-safe-themes t)
(load-theme 'airline-solarized-alternate-gui t)
;(setq airline-cursor-colors nil)
(setq evil-emacs-state-cursor   "#d3869b")
(setq evil-normal-state-cursor  "#928374")
(setq evil-insert-state-cursor  `(bar ,"#83a598"))
(setq evil-replace-state-cursor "#8ec07c")
(setq evil-visual-state-cursor  "#fe8019")

(require 'diminish)
(eval-after-load "intero" '(diminish 'intero-mode))
(eval-after-load "company" '(diminish 'company-mode))
(eval-after-load 'flycheck '(diminish 'flycheck-mode))
(eval-after-load "undo-tree" '(diminish 'undo-tree-mode))

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

;; esc quits
(defun minibuffer-keyboard-quit ()
  "Abort recursive edit.
In Delete Selection mode, if the mark is active, just deactivate it;
then it takes a second \\[keyboard-quit] to abort the minibuffer."
  (interactive)
  (if (and delete-selection-mode transient-mark-mode mark-active)
      (setq deactivate-mark  t)
    (when (get-buffer "*Completions*") (delete-windows-on "*Completions*"))
    (abort-recursive-edit)))
(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)
(global-set-key [escape] 'evil-exit-emacs-state)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (gruvbox)))
 '(custom-safe-themes
   (quote
    ("a20e430c1a70876d238a788d2529368c1dddd326c1bbb50ee4507ced6b37990b" "e87a2bd5abc8448f8676365692e908b709b93f2d3869c42a4371223aab7d9cf8" "b4caea661085e0df54e908fcedf96fb3755ba5e67f72b140c849c8876e5e4e31" "a164837cd2821475e1099911f356ed0d7bd730f13fa36907895f96a719e5ac3e" default)))
 '(inhibit-startup-screen t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(airline-emacs-outer ((t (:background "#d3869b" :foreground "#282828" :weight normal))))
 '(airline-insert-center ((t (:background "#504945" :foreground "#bdae93" :weight normal))))
 '(airline-insert-inner ((t (:background "#504945" :foreground "#bdae93" :weight normal))))
 '(airline-insert-outer ((t (:background "#83a598" :foreground "#282828" :weight normal))))
 '(airline-normal-center ((t (:background "#3c3836" :foreground "#a89984" :weight normal))))
 '(airline-normal-inner ((t (:background "#504945" :foreground "#bdae93" :weight normal))))
 '(airline-normal-outer ((t (:background "#928374" :foreground "#282828" :weight normal))))
 '(airline-replace-outer ((t (:background "#8ec07c" :foreground "#282828" :weight normal))))
 '(airline-visual-center ((t (:background "#7c6f64" :foreground "#282828" :weight normal))))
 '(airline-visual-inner ((t (:background "#504945" :foreground "#bdae93" :weight normal))))
 '(airline-visual-outer ((t (:background "#fe8019" :foreground "#282828" :weight normal))))
 '(nlinum-relative-current-face ((t (:inherit linum :background "#282828" :foreground "#7c6f64" :weight bold)))))
(setq backup-directory-alist
     `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
     `((".*" ,temporary-file-directory t)))
