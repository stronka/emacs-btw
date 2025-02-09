(setq inhibit-startup-message t)
(setq visible-bell t)

(display-time)

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
(recentf-mode 1)

;; enable electric-pair-mode for all buffers
(electric-pair-mode 1)

(add-hook 'emacs-lisp-mode-hook
	  (lambda ()
	    (electric-pair-mode 1)))

;; Init packages and add MELPA to it
;; Not sure about how I feel about this yet
(require 'package)
(add-to-list 'package-archives '("melpa", "https://melpa.org/packages/"))
;; (package-initialize)

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
(setq evil-default-state 'emacs)
(evil-mode 1)

;; Configuring vim familiarities
;; nnoremap <space> :
(evil-define-key 'normal 'global " " 'evil-ex)

;; END OF VIM SECTION

;; PROGRAMMING RELATED STUFF
;; C programming
(setq compilation-ask-about-save nil)

(defun find-makefile-dir ()
  "Go upwards through the directory structure until a makefile is foud."
  (let ((makefile-dir (locate-dominating-file default-directory "Makefile")))
    (if makefile-dir
	makefile-dir
      default-directory)))

 (defun build-makefile ()
   (interactive)
   (let ((default-directory (find-makefile-dir)))
     (compile "make -k")))

(defun execute-makefile ()
  (interactive)
  (let ((default-directory (find-makefile-dir)))
  (compile "make -k run")))

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
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(evil)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; DIRED
(setq dired-dwim-target 1)
