(setq inhibit-startup-message t)

(tool-bar-mode -1)
;;(menu-bar-mode -1)
(scroll-bar-mode -1)

(require 'package)
(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
	("marmalade" . "https://marmalade-repo.org/packages/")
	("melpa-stable" . "http://stable.melpa.org/packages/" )
	("melpa" . "http://melpa.org/packages/")
	))
(package-initialize)

(unless (package-installed-p 'use-package)
  (progn
    (package-refresh-contents)
    (package-install 'use-package)))



(setq evil-want-C-u-scroll 1)
(require 'evil)
(evil-mode 1)

(require 'helm)
(require 'helm-config)

;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

(when (executable-find "curl")
  (setq helm-google-suggest-use-curl-p t))

(setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
      helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
      helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t)

(helm-mode 1)
(helm-autoresize-mode t)
(global-set-key (kbd "M-x") 'helm-M-x)
(setq helm-M-x-fuzzy-match t)
(global-set-key (kbd "C-x b") 'helm-mini)
(setq helm-buffers-fuzzy-matching t
      helm-recentf-fuzzy-match t)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
;; (when (executable-find "ack-grep")
;;   (setq helm-grep-default-command "ack-grep -Hn --no-group --no-color %e %p %f"
;; 	helm-grep-default-recurse-command "ack-grep -H --no-group --no-color %e %p %f"))
;; ))

(require 'projectile)
(projectile-global-mode)

(require 'helm-projectile)
(setq projectile-completion-system 'helm)
(helm-projectile-on)

(require 'monokai-theme)
(load-theme 'monokai t)

(add-hook 'c++-mode-hook '(lambda () (progn
				       (require 'rtags)
				       (local-set-key (kbd "C-0") 'rtags-find-symbol-at-point)
				       (local-set-key (kbd "C-9") 'rtags-location-stack-back)
				       (local-set-key (kbd "C-8") 'rtags-find-references-at-point)
				       )))
(add-hook 'c-mode-hook '(lambda () (progn
				     (require 'rtags)
				     (local-set-key (kbd "C-0") 'rtags-find-symbol-at-point)
				     (local-set-key (kbd "C-9") 'rtags-location-stack-back)
				     (local-set-key (kbd "C-8") 'rtags-find-references-at-point)
				     )))


(require 'powerline)
(powerline-default-theme)

(require 'company)
(global-company-mode t)

(require 'ace-jump-mode)
(eval-after-load "ace-jump-mode"
  '(ace-jump-mode-enable-mark-sync))
;;(define-key global-map (kbd "C-x SPC") 'ace-jump-mode-pop-mark)
;;If you use evil
(define-key evil-normal-state-map (kbd "SPC") 'ace-jump-mode)

(require 'aggressive-indent)
(global-aggressive-indent-mode 1)

(require 'smartparens-config)
(smartparens-global-mode t)
(show-smartparens-global-mode t)

(require 'evil-surround)
(global-evil-surround-mode 1)
;; (setq TeX-auto-save t)
;; (setq TeX-parse-self t)
;; (setq-default TeX-master nil)

;; 	  ))
(yas-global-mode 1)

(add-hook 'org-mode-hook '(lambda () (auto-fill-mode t)))

(desktop-save-mode 1)


;; proxy
(defun start_qujing ()
  (interactive)
  (setq url-proxy-services '(("http" . "theironislands.f.getqujing.net:3128")))
  (setq url-http-proxy-basic-auth-storage
	(list (list "theironislands.f.getqujing.net:3128"
		    (cons "Input your LDAP UID !"
			  (base64-encode-string "359993151@qq.com:a8024568")))))
  )

(defun stop_qujing ()
  (interactive)
  (setq url-proxy-services nil)
  (setq url-http-proxy-basic-auth-storage nil)
  )
(require 'google-this)
;; ==================== DICT ==================================
(defun online-dict ()
  "Search current word in bing dictionary."
  (interactive)
  (google-this-string nil (concat "define "(thing-at-point 'word)) t)
  )
(global-set-key (kbd "C-c d") 'online-dict)
(require 'tabbar)
(global-set-key (kbd "C-<left>") 'tabbar-backward-tab)
(global-set-key (kbd "C-<right>") 'tabbar-forward-tab)
(global-set-key (kbd "C-<up>") 'tabbar-backward-group)
(global-set-key (kbd "C-<down>") 'tabbar-forward-group)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-backends
   (quote
    (company-rtags company-bbdb company-nxml company-css company-eclim company-semantic company-xcode company-cmake company-capf
		   (company-dabbrev-code company-gtags company-etags company-keywords)
		   company-oddmuse company-files company-dabbrev)))
 '(neo-dont-be-alone t)
 '(neo-smart-open t)
 '(neo-theme (quote ascii))
 '(tabbar-auto-scroll-flag t)
 '(tabbar-mode t nil (tabbar))
 '(tabbar-mwheel-mode t nil (tabbar))
 '(tabbar-separator (quote ("|")))
 '(tabbar-use-images nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(tabbar-button ((t (:inherit tabbar-default :background "dim gray" :foreground "gainsboro"))))
 '(tabbar-default ((t (:inherit variable-pitch :background "dim gray" :foreground "white smoke" :height 0.8))))
 '(tabbar-modified ((t (:inherit tabbar-default :foreground "orange"))))
 '(tabbar-selected ((t (:inherit nil :background "gray16" :foreground "gainsboro"))))
 '(tabbar-separator ((t (:background "dim gray" :foreground "gainsboro"))))
 '(tabbar-unselected ((t (:inherit nil :background "dim gray" :foreground "gainsboro")))))

