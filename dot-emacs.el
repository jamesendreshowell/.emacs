;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; James Endres Howell             .emacs (initialization file)
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; package configuration
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
			 ("melpa-stable" . "https://stable.melpa.org/packages/")))

(package-initialize)

;;; Set the default "load-path" to my "emacs" directory on Dropbox
(setq load-path (cons "~/Dropbox/emacs/" load-path))
(setq load-path (cons "~/Dropbox/emacs/elisp" load-path))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; real-auto-save
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'real-auto-save)
(add-hook 'org-mode-hook 'real-auto-save-mode)
(setq real-auto-save-interval 5) ;; in seconds

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; org-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq org-export-with-smart-quotes t)

(add-hook 'org-mode-hook 'auto-fill-mode)
(add-hook 'org-mode-hook 'turn-on-font-lock) ; not needed when global-font-lock-mode is on
(add-hook 'org-agenda-mode-hook 'hl-line-mode)

;; I want these keys to work from everywhere
;; (although it must be admitted I RARELY use org-store-link)
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

;; I use narrow and widen all the time to focus on one subtree
(defun jeh/set-org-mode-keys ()
  (local-set-key (kbd "C-c n") 'org-narrow-to-subtree)
  (local-set-key (kbd "C-c N") 'widen)
  (local-set-key (kbd "C-c C-.") 'org-archive-subtree)

  ;; insert a hyperlink
  (local-set-key (kbd "C-c C-S-l")
		 (lambda () (interactive)
		   (insert "[[][text]]")
		   (backward-char 6)))

  ;; More keybinding customization:
  ;; Generally in emacs, Ctrl-up/down arrows move backward/forward by a
  ;; "paragraph," but this is rarely useful and mostly confusing behavior.
  ;; It makes more sense (to me) for Ctrl-up/down arrows to do
  ;; the same thing as Meta-up/down arrows; and simply give up the default
  ;; jumping behavior of Ctrl-up/down within org-mode
  ;; org-metadown[up] calls `org-move-subtree-down[up]' or `org-table-move-row[up]' or
  ;; `org-move-item-down[up]', depending on context.
  (local-set-key (kbd "<C-up>") 'org-metaup)
  (local-set-key (kbd "<C-down>") 'org-metadown)


  ;; ADDED 2017-11-14
  ;; 
  (local-set-key (kbd "C-c C-c") 'org-toggle-checkbox)
  (local-set-key (kbd "M-S-<Ret>") 'org-toggle-checkbox)

)
(add-hook 'org-mode-hook 'jeh/set-org-mode-keys)

; The following makes M-return put the next outline heading on
; the next line, rather than after the intervening text. When I
; type free-form outlines, such insertions tend to be orphaned
; rubbish rather than subordinate content.
(setq org-insert-heading-respect-content nil)

(setq org-hide-leading-stars t)
(setq org-startup-folded t)
(setq org-align-all-tags t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; ibuffer
;;;
;;; A dired-style buffer-based interface for switching buffers
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(global-set-key (kbd "C-x b") 'ibuffer)
(add-hook 'ibuffer-mode-hook 'hl-line-mode) ;;; highlight line at mark


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; dired
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-hook 'dired-mode-hook 'hl-line-mode)  ;;; highlight line at mark


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; basic emacs configuration
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-hook 'text-mode-hook 'auto-fill-mode)
(setq sentence-end-double-space nil)
(setq fill-column 40)
(setq inhibit-startup-message t)
(setq initial-scratch-message "")
(setq inhibit-startup-echo-area-message t) ; Just for Aquamacs, custom obnoxious welcome message

;(scroll-bar-mode -1) ; previously was: (setq scroll-bar-mode nil)
;(setq scroll-bar-mode nil)
;(tool-bar-mode -1) ; previously was:
;(setq tool-bar-mode nil)
;(menu-bar-mode -1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Store autosave files (#foo#)
;;; and backup files (foo~)
;;; in Dropbox, hidden away in special directories
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(make-directory "~/Dropbox/emacs/autosave-files/" t)     ;; create the autosave dir if necessary
(make-directory "~/Dropbox/emacs/backup-files/" t)       ;; create the backups dir if necessary
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-file-name-transforms (quote ((".*" "~/Dropbox/emacs/autosave-files//\\1" t))))
 '(backup-directory-alist (quote ((".*" . "~/Dropbox/emacs/backup-files/"))))
 '(custom-enabled-themes (quote (sanityinc-solarized-light)))
 '(custom-safe-themes
   (quote
    ("4cf3221feff536e2b3385209e9b9dc4c2e0818a69a1cdb4b522756bcdf4e00a4" default)))
 '(line-spacing 0.2)
 '(org-agenda-files (quote ("~/Dropbox/emacs/org-files/notes.org")))
 '(package-selected-packages (quote (org-edna color-theme-sanityinc-solarized)))
 '(tool-bar-mode nil))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Keyboard customizations
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Ctrl-plus and Ctrl-minus adjust font-size
(global-set-key (kbd "C-=") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)


;; Quick shortcut to this file, my configuration file,
;; which I am needless to say endlessly tweaking
(global-set-key "\C-xe" (lambda () (interactive) (find-file "~/.emacs")))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; AFTER package initialization
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun jeh/after-init-hook ()
  ;; stolen from:
  ;; stackoverflow.com/questions/11127109/emacs-24-package-system-initialization-problems/11140619#11140619
  ;; .emacs is evaluated, then packages are initialized,
  ;; and THEN the following are evaluated:
  ;; (e.g. solarized-theme from marmalade)
  (when window-system 
    (set-frame-size (selected-frame) 88 65)
    (set-frame-position (selected-frame) 0 0)
    ))
(add-hook 'after-init-hook 'jeh/after-init-hook)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Courier" :foundry "unknown" :slant normal :weight normal :height 144 :width normal))))
 '(org-level-1 ((t (:foreground "#0000ff"))))
 '(org-level-2 ((t (:foreground "#6666ff")))))

(eval-after-load "ox-latex"
  '(add-to-list 'org-latex-classes
                '("koma-article" "\\documentclass{scrartcl}"
                  ("\\section{%s}" . "\\section*{%s}")
                  ("\\subsection{%s}" . "\\subsection*{%s}")
                  ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                  ("\\paragraph{%s}" . "\\paragraph*{%s}")
                  ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))))

;;;; MARKDOWN MODE

(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(autoload 'gfm-mode "markdown-mode"
   "Major mode for editing GitHub Flavored Markdown files" t)
(add-to-list 'auto-mode-alist '("README\\.md\\'" . gfm-mode))


;;; DARKROOM.el
(require 'darkroom)

;;;; minimal.el
(autoload 'minimal-mode "minimal"
   "Minor mode for minimal screen" t)


(find-file "~/Dropbox/emacs/org-files/notes.org")

