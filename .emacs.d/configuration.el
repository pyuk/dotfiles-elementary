
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq header-line-format "hello")
(set-frame-font "PragmataPro-8")
(setq frame-title-format '("%b" " - " invocation-name))
;(when window-system (set-frame-size (selected-frame) 75 45))
(set-register ?e '(file . "~/.emacs.d/configuration.org"))
(set-register ?c '(file . "/etc/nixos/configuration.nix"))
(setq org-src-fontify-natively t)
(load-theme 'zenburn t)
;(setq
;  backup-by-copying t      ; don't clobber symlinks
;  backup-directory-alist
;   '(("." . "~/.saves"))    ; don't litter my fs tree
;  delete-old-versions t
;  kept-new-versions 6
;  kept-old-versions 2
;  version-control t)       ; use versioned backups
(defun sudo-save ()
  (interactive)
  (if (not buffer-file-name)
      (write-file (concat "/sudo:root@localhost:" (ido-read-file-name "File:")))
(write-file (concat "/sudo:root@localhost:" buffer-file-name))))
(setq backup-directory-alist
      `((".*" . ,"~/.saves")))
(setq auto-save-file-name-transforms
      `((".*" ,"~/.saves" t)))

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

(evil-leader/set-key
    "," 'save-buffer
    "q" 'save-buffers-kill-terminal
    "n" 'evil-end-of-line
    "d" 'evil-beginning-of-line
    "u" 'intero-repl
    "c" 'intero-repl-load
    "N" 'flycheck-next-error
    "D" 'flycheck-previous-error
    ";" 'self-insert-command
    "f" 'helm-find-files
    "o" 'other-window
    "1" 'delete-other-windows
    "2" 'split-window-below
    "3" 'split-window-right
    "b" 'helm-buffers-list
    "g" 'magit-status
    "p" 'helm-projectile
    "r" 'haskell-process-load-file
    "s" 'window-configuration-to-register
    "l" 'jump-to-register
    "=" 'balance-windows
    "<SPC>" 'sudo-save
    "k" 'kill-buffer)

(require 'nlinum-relative)
;(global-nlinum-relative-mode t)
;(setq global-nlinum-relative-mode '(not pdf-view-mode))
(define-global-minor-mode my-nlinum-mode nlinum-relative-mode
  (lambda ()
    (when (not (memq major-mode
                     (list 'pdf-view-mode)))
      (nlinum-relative-mode 1))))
(my-nlinum-mode 1)
(nlinum-relative-setup-evil)                    ;; setup for evil
(add-hook 'prog-mode-hook 'nlinum-relative-mode)
(setq nlinum-relative-redisplay-delay 0)      ;; delay
(setq nlinum-relative-current-symbol "")      ;; or "" for display current line number
(setq nlinum-relative-offset 0)                 ;; 1 if you want 0, 2, 3...

(require 'helm-config)
(helm-mode 1)
(helm-autoresize-mode t)

(projectile-mode)
(setq projectile-compleetion-sysetm 'helm)
(require 'helm-projectile)
(helm-projectile-on)

(require 'org)
(org-indent-mode 1)

(require 'diminish)
;(eval-after-load "intero" '(diminish 'intero-mode))
;(eval-after-load "company" '(diminish 'company-mode))
(eval-after-load 'flycheck '(diminish 'flycheck-mode))
(eval-after-load "undo-tree" '(diminish 'undo-tree-mode))
(eval-after-load "helm" '(diminish 'helm-mode))
(eval-after-load "projectile" '(diminish 'projectile-mode))

;(require 'smooth-scrolling)
;(smooth-scrolling-mode 1)

(define-fringe-bitmap 'right-curly-arrow
  [#b00000000
   #b00000000
   #b00000000
   #b00000000
   #b01110000
   #b00010000
   #b00010000
   #b00000000])
(define-fringe-bitmap 'left-curly-arrow
  [#b00000000
   #b00001000
   #b00001000
   #b00001110
   #b00000000
   #b00000000
   #b00000000
   #b00000000])

(global-set-key (kbd "M-3") 'ace-window)
(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to do persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key(kbd "M-h") 'evil-scroll-down)
(global-set-key(kbd "M-t") 'evil-scroll-up)

(define-key org-mode-map (kbd "M-h") nil)
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "S-C-d") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-n") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-t") 'shrink-window)
(global-set-key (kbd "S-C-h") 'enlarge-window)

(add-hook 'after-init-hook #'global-flycheck-mode)
(eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook #'flycheck-haskell-setup))
;(add-hook 'flycheck-mode-hook #'flycheck-haskell-setup)
(require 'haskell-interactive-mode)
(require 'haskell-process)
(add-hook 'haskell-mode-hook (lambda () (setq evil-auto-indent nil)))
(add-hook 'haskell-mode-hook 'interactive-haskell-mode)
(setq flycheck-command-wrapper-function
        (lambda (command) (apply 'nix-shell-command (nix-current-sandbox) command))
      flycheck-executable-find
        (lambda (cmd) (nix-executable-find (nix-current-sandbox) cmd)))
;(add-hook 'haskell-mode-hook 'intero-mode)

;; For emacs25
(setq prettify-symbols-unprettify-at-point t)

(defconst pragmatapro-prettify-symbols-alist
  (mapcar (lambda (s)
            `(,(car s)
              .
              ,(concat
                (list ?\C-i)
                (list (decode-char 'ucs (cadr s))))))
          (list '("[ERROR]"   #XE380)
                '("[DEBUG]"   #XE381)
                '("[INFO]"    #XE382)
                '("[WARN]"    #XE383)
                '("[WARNING]" #XE384)
                '("[ERR]"     #XE385)
                '("[FATAL]"   #XE386)
                '("[TRACE]"   #XE387)
                '("!!"        #XE720)
                '("!="        #XE721)
                '("!=="       #XE722)
                '("!!!"       #XE723)
                '("!≡"        #XE724)
                '("!≡≡"       #XE725)
                '("!>"        #XE726)
                '("#("        #XE740)
                '("#_"        #XE741)
                '("#{"        #XE742)
                '("#?"        #XE743)
                '("#>"        #XE744)
                '("##"        #XE745)
                '("%="        #XE750)
                '("%>"        #XE751)
                '("&%"        #XE760)
                '("&&"        #XE761)
                '("&*"        #XE762)
                '("&+"        #XE763)
                '("&-"        #XE764)
                '("&/"        #XE765)
                '("&="        #XE766)
                '("&&&"       #XE767)
                '("&>"        #XE768)
                '("***"       #XE780)
                '("*="        #XE781)
                '("*/"        #XE782)
                '("*>"        #XE783)
                '("++"        #XE790)
                '("+++"       #XE791)
                '("+="        #XE792)
                '("+>"        #XE793)
                '("++="       #XE794)
                '("--"        #XE7A0)
                '("-<"        #XE7A1)
                '("-<<"       #XE7A2)
                '("-="        #XE7A3)
                '("->"        #XE7A4)
                '("->>"       #XE7A5)
                '("---"       #XE7A6)
                '("-->"       #XE7A7)
                '("-+-"       #XE7A8)
                '("-\\/"      #XE7A9)
                '(".."        #XE7B0)
                '("..."       #XE7B1)
                '("..<"       #XE7B2)
                '(".>"        #XE7B3)
                '(".~"        #XE7B4)
                '(".="        #XE7B5)
                '("/*"        #XE7C0)
                '("//"        #XE7C1)
                '("/>"        #XE7C2)
                '("/="        #XE7C3)
                '("/=="       #XE7C4)
                '("///"       #XE7C5)
                '("/**"       #XE7C6)
                '("::"        #XE7D0)
                '(":="        #XE7D1)
                '(":≡"        #XE7D2)
                '(":>"        #XE7D3)
                '(":=>"       #XE7D4)
                '("<$>"       #XE7E0)
                '("<*"        #XE7E1)
                '("<*>"       #XE7E2)
                '("<+>"       #XE7E3)
                '("<-"        #XE7E4)
                '("<<"        #XE7E5)
                '("<<<"       #XE7E6)
                '("<<="       #XE7E7)
                '("<="        #XE7E8)
                '("<=>"       #XE7E9)
                '("<>"        #XE7EA)
                '("<|>"       #XE7EB)
                '("<<-"       #XE7EC)
                '("<|"        #XE7ED)
                '("<=<"       #XE7EE)
                '("<~"        #XE7EF)
                '("<~~"       #XE7F0)
                '("<<~"       #XE7F1)
                '("<$"        #XE7F2)
                '("<+"        #XE7F3)
                '("<!>"       #XE7F4)
                '("<@>"       #XE7F5)
                '("<#>"       #XE7F6)
                '("<%>"       #XE7F7)
                '("<^>"       #XE7F8)
                '("<&>"       #XE7F9)
                '("<?>"       #XE7FA)
                '("<.>"       #XE7FB)
                '("</>"       #XE7FC)
                '("<\\>"      #XE7FD)
                '("<\">"      #XE7FE)
                '("<:>"       #XE7FF)
                '("<~>"       #XE800)
                '("<**>"      #XE801)
                '("<<^"       #XE802)
                '("<!"        #XE803)
                '("<@"        #XE804)
                '("<#"        #XE805)
                '("<%"        #XE806)
                '("<^"        #XE807)
                '("<&"        #XE808)
                '("<?"        #XE809)
                '("<."        #XE80A)
                '("</"        #XE80B)
                '("<\\"       #XE80C)
                '("<\""       #XE80D)
                '("<:"        #XE80E)
                '("<->"       #XE80F)
                '("<!--"      #XE810)
                '("<--"       #XE811)
                '("<~<"       #XE812)
                '("<==>"      #XE813)
                '("=<<"       #XE820)
                '("=="        #XE821)
                '("==="       #XE822)
                '("==>"       #XE823)
                '("=>"        #XE824)
                '("=~"        #XE825)
                '("=>>"       #XE826)
                '("=/="       #XE827)
                '("≡≡"        #XE830)
                '("≡≡≡"       #XE831)
                '("≡:≡"       #XE832)
                '(">-"        #XE840)
                '(">="        #XE841)
                '(">>"        #XE842)
                '(">>-"       #XE843)
                '(">>="       #XE844)
                '(">>>"       #XE845)
                '(">=>"       #XE846)
                '(">>^"       #XE847)
                '("??"        #XE860)
                '("?~"        #XE861)
                '("?="        #XE862)
                '("?>"        #XE863)
                '("???"       #XE864)
                '("^="        #XE868)
                '("^."        #XE869)
                '("^?"        #XE86A)
                '("^.."       #XE86B)
                '("^<<"       #XE86C)
                '("^>>"       #XE86D)
                '("^>"        #XE86E)
                '("\\\\"      #XE870)
                '("\\>"       #XE871)
                '("\\/-"      #XE872)
                '("@>"        #XE877)
                '("|="        #XE880)
                '("||"        #XE881)
                '("|>"        #XE882)
                '("|||"       #XE883)
                '("|+|"       #XE884)
                '("|->"       #XE885)
                '("|-->"      #XE886)
                '("|=>"       #XE887)
                '("|==>"      #XE888)
                '("~="        #XE890)
                '("~>"        #XE891)
                '("~~>"       #XE892)
                '("~>>"       #XE893)
                '("\">"       #XE8B0))))

(defun add-pragmatapro-prettify-symbols-alist ()
  (dolist (alias pragmatapro-prettify-symbols-alist)
    (push alias prettify-symbols-alist))
  (prettify-symbols-mode -1)
  (prettify-symbols-mode +1))

(add-hook 'prog-mode-hook
          #'add-pragmatapro-prettify-symbols-alist)

(global-prettify-symbols-mode +1)
