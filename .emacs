;;;--------------- Packages ---------------
(require 'cl)
(require 'package) ;; You might already have this line
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)


;; Check to see if require packages are installed
(defvar required-packages
  '(
    elpy
    jedi
    exec-path-from-shell
    flycheck
    ido-vertical-mode
    markdown-mode
    monokai-theme
  ) "a list of packages to ensure are installed at launch.")

; method to check if all packages are installed
(defun packages-installed-p ()
  (loop for p in required-packages
        when (not (package-installed-p p)) do (return nil)
        finally (return t)))

; if not all packages are installed, check one by one and install the missing ones.
(unless (packages-installed-p)
  ; check for new packages (package versions)
  (message "%s" "Emacs is now refreshing its package database...")
  (package-refresh-contents)
  (message "%s" " done.")
  ; install the missing packages
  (dolist (p required-packages)
    (when (not (package-installed-p p))
      (package-install p))))


;; Loading the Monokai theme for emacs
(load-theme 'monokai t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ac-max-width nil)
 '(eldoc-idle-delay 0.1)
 '(electric-pair-mode t)
 '(elpy-eldoc-show-current-function nil)
 '(elpy-modules
   (quote
    (elpy-module-eldoc elpy-module-pyvenv elpy-module-yasnippet elpy-module-sane-defaults)))
 '(elpy-rpc-backend "jedi")
 '(elpy-rpc-python-command "~/anaconda/bin/python")
 '(elpy-set-backend "jedi")
 '(global-linum-mode t)
 '(ido-enable-flex-matching t)
 '(ido-mode t nil (ido))
 '(ido-vertical-mode t)
 '(jedi:tooltip-method nil)
 '(load-prefer-newer t)
 '(markdown-mode t)
 '(mouse-yank-at-point t)
 '(python-shell-interpreter "~/anaconda/bin/ipython")
 '(require-final-newline t)
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(uniquify-buffer-name-style (quote forward) nil (uniquify))
 '(winner-mode t))


;; Sets the path variables to match shell
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;; Enable elpy
(elpy-enable)

;; Jedi for python
(add-hook 'python-mode-hook 'jedi:setup)

;; Flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)

(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

;; Setting auto backup and autosave locations
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))
(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/auto-save-list/" t)))

;; Setting the directory name to display in the window frame
(setq frame-title-format
      (list (format "%s %%S: %%j " (system-name))
        '(buffer-file-name "%f" (dired-directory dired-directory "%b"))))

;; Setting Elpy syntax checker
(setq python-check-command (expand-file-name "~/anaconda/bin/flake8"))

;; make electric-pair-mode work on more brackets
(setq electric-pair-pairs '((?\" . ?\")(?\{ . ?\})(?\' . ?\')))

;; Load markdown mode
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("README\\.md\\'" . gfm-mode))

;; Setting global keys
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "M-/") 'hippie-expand)

;; Set font
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#272822" :foreground "#F8F8F2" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight thin :height 110 :width normal :foundry "nil" :family "Menlo")))))
