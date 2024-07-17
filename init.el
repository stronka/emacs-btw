(setq inhibit-startup-message t)
(setq visible-bell t)

;; THEME CONFIGURATION
;; Adjust UI
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; Line numbers gutter
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode 1)

(setq modus-themes-vivendi-color-overrides '((bg-main . "#201829")
      (fg-main . "#fff6cf")))

(load-theme 'modus-vivendi)

(setq modus-themes-mixed-fonts t)
(set-face-attribute 'default nil :family "FiraCode Nerd Font Mono" :weight 'bold :height 110)
(set-face-attribute 'variable-pitch nil :family "Alef" :weight 'normal' :width 'narrow' :height 1.2)
(set-face-attribute 'fixed-pitch nil :family "FiraCode Nerd Font Mono" :weight 'bold :height 1.1)
;; END OF THEME

;; GENERAL UTILITIES PART
;; Recent files mode

;; enable electric-pair-mode for all buffers
(electric-pair-mode 1)

(add-hook 'emacs-lisp-mode-hook
	  (lambda ()
	    (electric-pair-mode 1)))

;; Init packages and add MELPA to it
;; Not sure about how I feel about this yet
(require 'package)
(add-to-list 'package-archives '("melpa", "https://melpa.org/packages/"))
(package-initialize)

;; VI MODE & OTHER VIM FAMILIARITIES

;; I intend to use it as a crutch before I learn to get around emacs properly
;; But then again, I might actually never have to should the vim emulation be good enough

;; Viper is cool, but lacks text objects
;; (setq viper-mode t)
;; (require 'viper)
;; (setq viper-syntax-preference 'extended)

;; Evil is cool, but it's bloated, let's go with it *for now*
(unless (package-installed-p 'evil)
  (package-install 'evil))

(require 'evil)
(evil-mode 1)

;; Configuring vim familiarities
;; nnoremap <space> :
(evil-define-key 'normal 'global " " 'evil-ex)

;; It takes THIS much to emulate `inoremap jj <ESC>`
(defun xwl-jj-as-esc ()
  (interactive)
  (if (memq evil-state '(insert replace))
      (let ((changed? (buffer-modified-p)))
          (insert "j")
          (let* ((tm (current-time))
                 (ch (read-key)))
            (if (and (eq ch ?j)
                     (< (time-to-seconds (time-since tm)) 0.5))
                (save-excursion
                  (delete-char -1)
                  (evil-force-normal-state)
                  (set-buffer-modified-p changed?))
              (insert ch))))
    (call-interactively 'evil-next-line)))

(define-key evil-insert-state-map  "j" 'xwl-jj-as-esc)
(define-key evil-replace-state-map "j" 'xwl-jj-as-esc)
;; end of jj block

;; END OF VIM SECTION

;; PROGRAMMING RELATED STUFF
;; C programming
(defun build-makefile ()
  (interactive)
  (compile "make -k"))

(defun execute-makefile ()
  (interactive)
  (compile "make -k run"))

(global-set-key (kbd "C-<f9>") 'build-makefile)
(global-set-key (kbd "C-<f10>") 'execute-makefile)
;; END OF PROGRAMMING STUFF

;; IDK - commented out and stuff doesn't break for me lol
;; (custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 ;; '(package-selected-packages '(evil)))
;; (custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
;; )

