;; emacs configureation file
(require 'package)
(add-to-list 'package-archives
	     ;; MELPA emacs package repository
 '("melpa" . "https://melpa.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
  )
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

  (load (expand-file-name "~/quicklisp/slime-helper.el"))
  (setq inferior-lisp-program "sbcl")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (adwaita)))
 '(package-selected-packages (quote (god-mode auctex elpy))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(elpy-enable)
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(tooltip-mode nil) ;; One-line help text in echo area

;; Setting auto-indent behaviour.
;; With this setup, TAB - which is usually bound to indent-for-tab-command - first tries to adjust the indentation according to the mode's settings, but if the indentation is already correct, completion is triggered. This is usually the desired behavior, and IMHO works better than third-party plugins like smart-tab.
(setq tab-always-indent 'complete)
(add-to-list 'completion-styles 'initials t)

(require 'god-mode)
(global-set-key
 ;; Use ESC to toggle god-mode for all buffers, including every mode.
 (kbd "<escape>") 'god-mode-all)
(setq god-exempt-major-modes nil)
(setq god-exempt-predicates nil)
; From https://github.com/chrisdone/god-mode/issues/77
; This mortal mode is designed to allow temporary departures from god mode
; The idea is that within god-mode, you can hit shift-i, type in a few characters
; and then hit enter to return to god-mode. To avoid clobbering the previous bindings,
; we wrap up this behavior in a minor-mode.
(define-minor-mode mortal-mode
  "Allow temporary departures from god-mode."
  :lighter " mortal"
  :keymap '(([return] . (lambda ()
                          "Exit mortal-mode and resume god mode." (interactive)
                          (god-local-mode-resume)
                          (mortal-mode 0))))
  (when mortal-mode
    (god-local-mode-pause)))

(define-key god-local-mode-map (kbd "I") 'mortal-mode)
(define-key god-local-mode-map (kbd ".") 'repeat)
