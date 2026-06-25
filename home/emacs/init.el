;;; init.el --- my config
(set-face-attribute 'default nil :height 210)
; Dark mod
(load-theme 'modus-vivendi t)
(add-to-list 'default-frame-alist '(font . "DejaVu Sans Mono-21"))
; Remove backup files, auto save, and lock files.
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq create-lockfiles nil)
;; Insert spaces, never literal tab characters
; (setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq-default standard-indent 2)

(global-display-line-numbers-mode 1)
(setq whitespace-style '(face tabs spaces tab-mark space-mark trailing))
(global-whitespace-mode 1)
;; Don't show the splash/welcome screen at startup
(setq inhibit-startup-screen t)
;; Blank the *scratch* buffer message too (the "This buffer is for text..." comment)
(setq initial-scratch-message nil)

(use-package which-key
  :config
  (which-key-mode))

