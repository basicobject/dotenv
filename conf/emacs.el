;; frame set up
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
;; (set-frame-height (selected-frame) 60)
;; (set-frame-width (selected-frame) 260)
;; (set-frame-position (selected-frame) 10 30)
(set-background-color "black")
(set-foreground-color "white")
;; (set-cursor-color "white")
;; fix for buggy shell window
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil 1)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; set command key to be meta instead of option
(defun system-is-mac ()
  (interactive)
  (string-equal system-type "darwin"))

(defun system-is-linux ()
  (interactive)
  (string-equal system-type "gnu/linux"))

;; set command key to be meta instead of option
(if (system-is-mac)
    (setq ns-command-modifier 'meta))

;; SETTINGS
(setq-default indent-tabs-mode -1)
;; don't create annoying ~ files
(setq make-backup-files -1)
;; user email and website
(setq user-mail-address "deepakkumarnd@gmail.com")
(setq user-website "http://42races.github.com")

;; load plugins
(add-to-list 'load-path "~/.emacs.d/plugins")
;; set exec path for shell commands in /usr/local/bin
(add-to-list 'exec-path "/usr/local/bin")

;; MODES
;; mode settings
;; highlight matching paranthesis
(show-paren-mode 1)

;; Remove splash screen
(setq inhibit-startup-message 1)

;; ido-mode
(ido-mode 1)

;; show linenumbers
(global-linum-mode 1)

;; enable transient-mark-mode by default
(setq-default transient-mark-mode 1)

;; KEYBINDINGS
;; set keybindings
;; y or n instead of yes or no
(fset 'yes-or-no-p 'y-or-n-p)

;; personal key bindings
(defun comment-or-uncomment-region-or-line ()
  "Comments or uncomments the current line or region."
  (interactive)
  (if (region-active-p)
      (comment-or-uncomment-region (region-beginning) (region-end))
    (comment-or-uncomment-region (line-beginning-position) (line-end-position))))

(global-set-key (kbd "M-/") 'comment-or-uncomment-region-or-line)

;; detect trailing spaces plugin - highlight-char
;;(require 'highlight-chars)
;;(hc-toggle-highlight-trailing-whitespace)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(defun system-is-mac ()
  (interactive)
  (string-equal system-type "darwin"))

(defun system-is-linux ()
  (interactive)
  (string-equal system-type "gnu/linux"))

;; set command key to be meta instead of option
(if (system-is-mac)
    (setq ns-command-modifier 'meta))
(defun system-is-mac ()
  (interactive)
  (string-equal system-type "darwin"))

(defun system-is-linux ()
  (interactive)
  (string-equal system-type "gnu/linux"))

(require 'package)
(add-to-list 'package-archives
    '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)

;; remove trailing whitespaces and blank lines
(add-hook 'before-save-hook 'whitespace-cleanup)

;; reload if a file changed outside the buffer
(global-auto-revert-mode 1)

;; autosave directory
(defconst emacs-autosave-dir "~/tmp/autosave")
(setq auto-save-list-file-prefix  emacs-autosave-dir)
;; store all backup and autosave files in the tmp dir
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; init with external plugins


(load-file "~/.emacs.d/init.el")
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(region ((t (:background "gray29")))))
