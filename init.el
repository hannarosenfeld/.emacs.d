;; Elpa
(package-initialize)

(require 'use-package)

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
(add-hook 'write-file-hooks 'delete-trailing-whitespace nil t)

;; Highlight current line
(global-hl-line-mode 1)
(set-cursor-color "#f0dfaf")

;; Highlight matching pairs of parentheses and other characters when the point is on them.
(show-paren-mode 1)

;; Some users want to always use `y-or-n-p', never `yes-or-no-p'.
(defalias 'yes-or-no-p 'y-or-n-p)

;;org-capture
(define-key global-map "\C-cc" 'org-capture)
(setq org-capture-templates
      ;;inbox
      '(("i"
         "Inbox"
         entry
         (file+headline "~/gtd/inbox.org" "Tasks")
         "* TODO %?\n  %i\n  %a")
        ;;morning pages
        ("m"
         "Morning Pages"
         entry
         (file+datetree "~/gtd/morningpages.org")
         "* %U\n "
         )
        ("r"
         "Reference"
         entry
         (file+datetree "~/gtd/reference.org")
         "* %U\n "
         )
        ("j"
         "Journal"
         entry
         (file+datetree "~/gtd/journal.org")
         "* %U\n "
         )
        ))


;; org-refile
(setq org-refile-use-outline-path 'file)




;; https://orgmode.org/manual/Breaking-Down-Tasks.html
;; If you would like a TODO entry to automatically change to DONE when all children are done, you can use the following setup:
(defun org-summary-todo (n-done n-not-done)
  "Switch entry to DONE when all subentries are done, to TODO otherwise."
  (let (org-log-done org-log-states)   ; turn off logging
    (org-todo (if (= n-not-done 0) "DONE" "TODO"))))

(add-hook 'org-after-todo-statistics-hook #'org-summary-todo)


;; org-agenda
(setq org-agenda-files '("~/gtd/inbox.org"
                         "~/gtd/gtd.org"
                         "~/gtd/someday.org"))


;; refile
(setq org-refile-targets '(("~/gtd/gtd.org" :maxlevel . 3)
                           ("~/gtd/someday.org" :level . 1)
                           ("~/gtd/inbox.org" :level . 1)
                           ("~/gtd/reference.org" :maxlevel . 2)))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(use-package prettier-js prettier web-mode js2-mode zenburn-theme versuri rjsx-mode mpv melpa-upstream-visit major-mode-hydra lorem-ipsum lastfm ivy-hydra company bind-key auto-complete ansible)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; company mode in all buffers
(add-hook 'after-init-hook 'global-company-mode)

;; close html tags
(setq sgml-quick-keys 'close)

;; auto-complete
(ac-config-default)

;; web-mode
;; https://web-mode.org/
;; https://gist.github.com/CodyReichert/9dbc8bd2a104780b64891d8736682cea
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsx?$" . web-mode)) ;; auto-enable for .js/.jsx files
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(setq web-mode-content-types-alist '(("jsx" . "\\.js[x]?\\'"))) ;; JSX syntax highlighting

(defun web-mode-init-hook ()
  "Hooks for Web mode.  Adjust indent."
  (setq web-mode-markup-indent-offset 4))

(add-hook 'web-mode-hook  'web-mode-init-hook)


;;rsjx-mode
(use-package rjsx-mode
             :ensure t
             :mode "\\.js\\'")

;;prettier
(add-to-list 'auto-mode-alist '("\\.jsx?$" . web-mode)) ;; auto-enable for .js/.jsx files
(setq web-mode-content-types-alist '(("jsx" . "\\.js[x]?\\'")))
