(setq gc-cons-threshold 100000000
      inhibit-startup-message t
      initial-scratch-message nil
      use-short-answers t
      scroll-conservatively 35
      scroll-margin 0
      scroll-step 1
      default-directory "c:/Users/name/Desktop/"
      command-line-default-directory "c:/Users/name/Desktop/"
      inhibit-compacting-font-caches t
      display-time-default-load-average nil
      display-time-24hr-format 1
      ring-bell-function 'ignore
      make-backup-files nil
      auto-save-default nil
      select-enable-clipboard t
      eval-expression-print-length nil
      eval-expression-print-level nil)

;; (require 'ffap)

(set-language-environment "Japanese")
(prefer-coding-system 'utf-8-unix)
(blink-cursor-mode -1)
(show-paren-mode)
(savehist-mode)
;; (electric-pair-mode t)
(add-to-list 'default-frame-alist '(cursor-type . bar))
(setq-default setq-defaulttab-width 4 indent-tabs-mode nil)

(global-set-key (kbd "M-\"") 'insert-pair)
(global-set-key (kbd "M-'") 'insert-pair)
(define-key global-map (kbd "C-v") 'yank)
(global-set-key (kbd "C-x C-k") 'kill-current-buffer)
(global-set-key (kbd "C-x C-p") 'previous-buffer)
(global-set-key (kbd "C-x C-n") 'next-buffer)
(global-set-key (kbd "M-RET") 'toggle-frame-fullscreen)
(global-set-key (kbd "C-M-f")
                (lambda()(interactive)(find-file "~/.emacs.d/init.el")))
(global-set-key (kbd "C-?") 'help-command)
(global-unset-key (kbd "C-? h"))
(global-set-key  "\C-h" 'delete-backward-char)
(global-unset-key (kbd "C-z"))
(global-set-key (kbd "C-z")   'undo)
(global-set-key (kbd "C-S-z") 'undo-redo)
(global-set-key (kbd "C-x C-b") 'electric-buffer-list)
(global-set-key (kbd "S-SPC")   'set-mark-command)

;;;; -- original functions -----------------------------------
(defun backward-kill-line (arg)
  "Kill chars backward until encountering the end of a line."
  (interactive "p")
  (kill-line 0))
(global-set-key (kbd "C-u") 'backward-kill-line)

(defun backward-kill-word-or-kill-region ()
  (interactive)
  (if (or (not transient-mark-mode) (region-active-p))
    (kill-region (region-beginning) (region-end))
    (backward-kill-word 1)))
(global-set-key (kbd "C-w") 'backward-kill-word-or-kill-region)

;;;; -- package ----------------------------------------------
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))

;; --- modus-theme --------------------------------
(setq modus-themes-org-blocks 'gray-background )
(load-theme 'modus-operandi)

(use-package mood-line
  :ensure t
  :config
  (mood-line-mode))

;;;; -- evil-mode --------------------------------------------
(use-package evil
  :ensure t
  :defer t
  :init
  ;; Set variables before evil is loaded
  (setq evil-undo-system 'undo-redo)
  (setq evil-toggle-key "C-,")
  (setq evil-want-C-i-jump nil)
  :config
  ;; Enable evil mode
  ;; (evil-mode 1)
  (evil-define-key 'insert 'global
    (kbd "C-a") nil
    (kbd "C-d") nil
    (kbd "C-e") nil
    (kbd "C-n") nil
    (kbd "C-p") nil
    (kbd "C-v") nil
    (kbd "C-t") nil
    (kbd "C-k") nil
    (kbd "C-.") nil
    (kbd "C-l") 'open-line
    )
  (evil-define-key 'normal 'global
    (kbd "C-.") nil
    (kbd "M-.") nil
    )
  (evil-define-key 'motion electric-buffer-menu-mode-map
    (kbd "RET") 'Electric-buffer-menu-select)

  (setq evil-normal-state-cursor 'hollow))

;; (global-evil-matchit-mode 1)
;; 
;; (global-evil-surround-mode 1)
;; 
(global-set-key (kbd "C-;") 'evilnc-comment-or-uncomment-lines)
;; (evilnc-default-hotkeys)
;; (define-key evil-normal-state-map ",c " 'evilnc-comment-or-uncomment-lines)
;; (define-key evil-visual-state-map ",c " 'evilnc-comment-or-uncomment-lines)

(use-package evil-numbers
  :ensure t
  :after evil
  :bind (:map evil-normal-state-map
              ("C-a" . evil-numbers/inc-at-pt)
              ("C--" . evil-numbers/dec-at-pt)
              ("g C-a" . evil-numbers/inc-at-pt-incremental)
              ("g C--" . evil-numbers/dec-at-pt-incremental)))



(use-package anzu
  :ensure t
  :config
  (global-anzu-mode))

(use-package evil-anzu
  :ensure t
  :after (evil anzu))

(use-package marginalia
  :ensure t
  :config
  (marginalia-mode))

(use-package vertico
  :ensure t
  :config
  (vertico-mode)
  (define-key vertico-map "?" #'minibuffer-completion-help)
  (define-key vertico-map (kbd "M-RET") #'minibuffer-force-complete-and-exit)
  (define-key vertico-map (kbd "M-TAB") #'minibuffer-complete))

(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

(use-package consult
  :ensure t
  )

(use-package embark
  :ensure t
  :bind
  (("C-." . embark-act );; pick some comfortable binding
   ("M-." . embark-dwim );; good alternative: M-.
   ;; ("C-h B" . embark-bindings)
   ))

(use-package embark-consult
  :ensure t
  :after (consult embark)
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

(use-package which-key
  :ensure t
  :config
  (which-key-mode)
  (which-key-setup-side-window-right-bottom)
  (setq which-key-show-early-on-C-h t))


(use-package org
  :defer t
  :config
  (org-babel-do-load-languages 'org-babel-load-languages
                               (append org-babel-load-languages
                                       '((awk . t)
                                         (ditaa . t)
                                         (shell . t)
                                         (java . t)
                                         (python . t)
                                         )))
  (setq org-src-window-setup 'current-window)
  (setq org-babel-python-command "python3")
  (setq org-adapt-indentation t)
  (setq org-html-postamble nil)
  ;; (setq org-export-with-toc nil)
  (setq org-export-with-author nil)
  (setq org-export-default-language "ja")
  ;; (setq org-html-doctype "html5")
  ;; (setq org-html-html5-fancy t)
  ;; (setq org-html-style
  ;; "<link rel='stylesheet' href='https://cdn.jsdelivr.net/npm/water.css@2/out/light.css'>")
  ;; (setq org-html-style
  ;;       " <style>
  ;;              table{border-collapse: collapse;
  ;;                    border-top : 1px solid black;
  ;;                    border-bottom : 1px solid black;}
  ;;              thead{border-bottom : 1px solid black;}
  ;;              th,td{padding:6px;}
  ;;         </style> ")
  ;; (setq org-html-checkbox-type 'unicode)
  (setq org-ditaa-jar-path "~/.emacs.d/ditaa-0.11.0-standalone.jar")
  (setq org-image-actual-width 300)
  (require 'ox-latex))

(use-package org-superstar
  :after org
  :init
  (setq org-superstar-leading-bullet ?\s)
  ;; (setq org-hidden-keywords '(title))
  (setq org-superstar-cycle-headline-bullets nil)
  :config
  (setq org-superstar-special-todo-items t)
  :hook (org-mode . org-superstar-mode))

(use-package org-re-reveal
  :after org
  :config
  ;; org-revral ------------------------------
  ;; (require 'ox-reveal)
  ;; (setq org-reveal-root "file:///usr/local/lib/node_modules/reveal.js")
  ;; CDN
  ;; (setq org-reveal-root "https://cdn.jsdelivr.net/npm/reveal.js")
  ;; org-re-revral ------------------------------
  (require 'org-re-reveal)
  ;; CDN
  (setq org-re-reveal-revealjs-version "4")
  (setq org-re-reveal-root "https://cdn.jsdelivr.net/npm/reveal.js")
  ;; (setq org-re-reveal-root "file:///usr/local/lib/node_modules/reveal.js")
)

(use-package persistent-scratch
  :ensure t
  :config
  (persistent-scratch-setup-default))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-echo-area-message "Username")
 )
 
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
