;;zenburn
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'zenburn t)

;; Turn off mouse interface early in startup to avoid momentary display
(dolist (mode '(menu-bar-mode tool-bar-mode scroll-bar-mode horizontal-scroll-bar-mode))
  (when (fboundp mode) (funcall mode -1)))

;; Disable startup message and customize scratch message.
(setq inhibit-startup-message t
      initial-scratch-message ";; Hi Hanna :)\n")

;; Include melpa in package-list-packages
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))

;; Globally set the default font.
(set-face-attribute 'default nil
                    :family "InconsolataGo Nerd Font" :height 140)

;; Turn off alarms completely.
(setq ring-bell-function 'ignore)

;; Column and line numbers
(setq-default column-number-mode t)
(when (version<= "26.0.50" emacs-version)
  (global-display-line-numbers-mode))

;; Use only spaces and set the tab width.
(setq-default indent-tabs-mode nil
              tab-width 4)
(add-hook 'html-mode-hook
      '(lambda()
        (setq c-basic-offset 4)
        (setq indent-tabs-mode nil)))

;; Show trailing whitespace and delete on save.
(setq-default show-trailing-whitespace t)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Highlight current line
(global-hl-line-mode 1)

;; Highlight matching pairs of parentheses and other characters when the point is on them.
(show-paren-mode 1)

(set-cursor-color "#f0dfaf")

;; Some users want to always use `y-or-n-p', never `yes-or-no-p'.
(defalias 'yes-or-no-p 'y-or-n-p)
