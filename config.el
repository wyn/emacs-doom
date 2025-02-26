;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Simon Parry"
      user-mail-address "simon.parry@karoshibee.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "monospace" :size 14 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "sans" :size 14)) ;; then do M-x doom/reload-fonts

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; trying to init emacs at a certain place
;; (setq initial-frame-alist '((top . 1630) (left . (0)) (width . 637) (height . 89)))

;; overwrite selected text
(delete-selection-mode t)


;; backspace is delete backwards, not help menu 
(normal-erase-is-backspace-mode 1)

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys

(load! "utils.el")

;; rebuilder config
(setq reb-re-syntax 'string)

;; global hide/show
(after! prog-mode-hook
  #'hs-minor-mode
  )

;; ocaml config
(after! tuareg-mode
  (load! "ocaml.el")
  )

(use-package! ocamlformat
  :custom (ocamlformat-enable 'enable-outside-detected-project)
  :hook (before-save . ocamlformat-before-save)
  )

(define-key projectile-mode-map  (kbd "C-c p") 'projectile-command-map)

;; rebind alt-3 for hash like other editors on mac
(fset 'insertPound "#")
(global-set-key (kbd "M-3") 'insertPound)
(setq display-line-numbers-type 'relative)

;; dap mode
(setq dap-auto-configure-mode t)

;; lsp config for smartpy dev
(use-package! lsp
  :init
  (setq lsp-pyls-plugins-pylint-enabled t)
  ;; (setq lsp-pyls-plugins-autopep8-enabled nil)
  ;; (setq lsp-pyls-plugins-yapf-enabled t)
  ;; (setq lsp-pyls-plugins-pyflakes-enabled nil)
  )

(after! lsp-mode
  ;; smartpy
  (add-to-list 'lsp-file-watch-ignored-directories "/home/wyn/dev/smartpy-private/_build")
  (add-to-list 'lsp-file-watch-ignored-directories "/home/wyn/dev/smartpy-private/_opam")
  (add-to-list 'lsp-file-watch-ignored-directories "/home/wyn/dev/smartpy-private/.cabal")
  (add-to-list 'lsp-file-watch-ignored-directories "/home/wyn/dev/smartpy-private/.opam")
  (add-to-list 'lsp-file-watch-ignored-directories "/home/wyn/dev/smartpy-private/test-baselines")
  (add-to-list 'lsp-file-watch-ignored-directories "/home/wyn/dev/")
  (add-to-list 'lsp-file-watch-ignored-directories "/home/wyn/")
  (setq lsp-file-watch-threshold 2000)
  )

;; NOTE the example in the docs assumes a string I think,
;; this should return a list of cli args for the
;; haskell-language-server-wrapper exe
(setq lsp-haskell-server-wrapper-function
      (lambda (argv)
        (append
         argv
         (list "--cwd" (concat (lsp--suggest-project-root) "haskell") "-j" "8")
         )
        )
      )

;; ipython/jupyter
(setq +python-ipython-repl-args '("-i" "--simple-prompt" "--no-color-info"))
(setq +python-jupyter-repl-args '("--simple-prompt"))
;; to debug with DAP-MODE
;;(requires 'dap-python)

;; smartpy user stuff
(load! "smartpy.el")

;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;;(load! "ligo.el")
;; (after! lsp-mode
;;   (after! ligo-mode
;;     (ligo-setup-lsp)
;;     )
;;   )

;; (require 'proof-site "~/.emacs.d/locals/straight/PG/generic/proof-site")
(load! "toggle-cursor-at-point.el")

;; org-roam
(use-package! org-roam
  :custom (org-roam-directory "~/roam")
  ;;  :config (org-roam-setup)
  )

;; mu4e email
(setq mu4e-headers-buffer-name "*mu4e-headers*")

(defun display-ansi-colors ()
  (interactive)
  (let ((inhibit-read-only t))
    (ansi-color-apply-on-region (point-min) (point-max))))
