;; Keep only one instance of emacs running
(setq-default ns-pop-up-frames nil)

;; ignore warning "recentf mode: Non-character input-event"
(setq create-lockfiles nil)

;; Replace the selected text when copy & parse
(delete-selection-mode 1)

(setq make-backup-files nil) ; stop creating backup~ files
(setq auto-save-default nil) ; stop creating #autosave# files

;; this fixed the issue that the helm will always keep only windows in spacemacs.
(setq helm-always-two-windows nil)

;; Dired setup
(require 'dired)
(setq dired-dwim-target t)                     ;; Enable copyd
(define-key dired-mode-map (kbd "<right>") 'dired-find-alternate-file) ;; dired-view-file
(define-key dired-mode-map (kbd "<left>")
  (lambda () (interactive) (find-alternate-file "..")))  ;; dired-up-directory

;; Elixir alchemist setup
(require 'alchemist)
(define-key elixir-mode-map (kbd "s-r") 'alchemist-iex-compile-this-buffer-and-go)
(define-key alchemist-iex-mode-map (kbd "s-;") 'alchemist-iex-clear-buffer)

(eval-after-load 'flycheck
  '(flycheck-credo-setup))
(add-hook 'elixir-mode-hook 'flycheck-mode)
(setq flycheck-elixir-credo-strict t)

(require 'flycheck-mix)
(flycheck-mix-setup)
;;(flycheck-add-next-checker 'elixir-mix '(t . elixir-credo) 'append) ;; setup the credo as the next syntax checker


;; (require 'flycheck-mix)

;; Android
;; Well, actually the emacs 25.1 already have the tramp for android, so we just
;; need to call ESC-f-f and type //adb:: to connect;

;;=================================================================================
;;                       better code indent
;;=================================================================================

;; Change c++ enum class indent
(defun inside-class-enum-p (pos)
  "Checks if POS is within the braces of a C++ \"enum class\"."
  (ignore-errors
    (save-excursion
      (goto-char pos)
      (up-list -1)
      (backward-sexp 1)
      (or (looking-back "enum\\s-+class\\s-+")
          (looking-back "enum\\s-+class\\s-+\\S-+\\s-*:\\s-*"))
      )
    )
  )

(defun align-enum-class (langelem)
  (if (inside-class-enum-p (c-langelem-pos langelem))
      0
    (c-lineup-topmost-intro-cont langelem)))

(defun align-enum-class-2 (langelem)
  (if (inside-class-enum-p (c-langelem-pos langelem))
      0
    '+))

(defun align-enum-class-closing-brace (langelem)
  (if (inside-class-enum-p (c-langelem-pos langelem))
      '-
    (c-lineup-topmost-intro-cont langelem)))

(c-add-style "Arantir"
             '("stroustrup"
               (indent-tabs-mode . nil)
               (c-basic-offset . 2)
               (c-offsets-alist
                (case-label . 2)
                (statement-cont . align-enum-class-closing-brace)
                (defun-block-intro . align-enum-class-2)
                (topmost-intro-cont . align-enum-class)
                (topmost-intro . 0)
                (comment-intro . 0)
                (inline-open . 0)
                (inline-close . 0)
                (namespace-open . 0)
                (namespace-close . 0)
                (innamespace . +))))

(push '(other . "Arantir") c-default-style)
(setq default-tab-width 2) ;; set default tab to 2
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode)) ;; load all .h file as c++ header
(add-to-list 'auto-mode-alist '("\\.cni\\'" . c++-mode)) ;; load all .chi file as c++
(add-to-list 'auto-mode-alist '("\\.mm\\'" . objc-mode)) ;; load all .mm file as objective-c file
(add-to-list 'auto-mode-alist '("\\.ham\\'" . sh-mode)) ;; load all .ham file as shell script

(with-eval-after-load ' projectile
  (push '("C" "h") projectile-other-file-alist))

;; js setup
(setq-default js2-basic-offset 2
              js-indent-level 2)

;; swift
(setq-default swift-mode:basic-offset 2)

(require 'company-sourcekit)
(add-to-list 'company-backends 'company-sourcekit)
(setq-default company-sourcekit-use-yasnippet nil)
;; (setq-default sourcekit-verbose 1)
;; (setq-default company-sourcekit-verbose 1)

;; java
(add-hook 'java-mode-hook (lambda () (setq c-basic-offset 2)))
;; (setq eclim-eclipse-dirs "/Applications/Eclipse.app/Contents/Eclipse"
;; eclim-executable "/Applications/Eclipse.app/Contents/Eclipse/eclim"
;; eclimd-executable "/Applications/Eclipse.app/Contents/Eclipse/eclimd"
;; eclimd-default-workspace "~/Work/projects")
;; (setq eclim-auto-save nil)

;; niscript
(load "~/.spacemacs.d/local/niscript.el")
(add-to-list 'auto-mode-alist '("\\.ni\\'" . niscript-mode))
(add-to-list 'auto-mode-alist '("\\.nip\\'" . niscript-mode))
(add-to-list 'auto-mode-alist '("\\.niw\\'" . niscript-mode))
(add-to-list 'auto-mode-alist '("\\.nil\\'" . niscript-mode))
(add-to-list 'auto-mode-alist '("\\.nit\\'" . niscript-mode))
(autoload 'niscript-mode "niScript" nil t)

;;=================================================================================
;;                       inline-string-rectangle
;;=================================================================================

(global-set-key (kbd "M-<down>") 'mc/mark-next-like-this)
(global-set-key (kbd "M-<up>") 'mc/unmark-next-like-this)
(global-set-key (kbd "M-S-<down>") 'mc/skip-to-next-like-this)
;; (global-set-key (kbd "M-S-<up>") 'mc/skip-to-previous-like-this)


(global-set-key (kbd "C-*") 'mc/mark-all-like-this)
(global-set-key (kbd "C-x r t") 'set-rectangular-region-anchor)

;;=================================================================================
;;                       toggle-camelcase-underscores
;;=================================================================================

(defun toggle-camelcase-underscores ()
  "Toggle between camelcase and underscore notation for the symbol at point."
  (interactive)
  (save-excursion
    (let* ((bounds (bounds-of-thing-at-point 'symbol))
           (start (car bounds))
           (end (cdr bounds))
           (currently-using-underscores-p (progn (goto-char start)
                                                 (re-search-forward "_" end t))))
      (if currently-using-underscores-p
          (progn
            (upcase-initials-region start end)
            (replace-string "_" "" nil start end)
            (downcase-region start (1+ start)))
        (replace-regexp "\\([A-Z]\\)" "_\\1" nil (1+ start) end)
        (downcase-region start (cdr (bounds-of-thing-at-point 'symbol)))))))

;;=================================================================================
;;                             Key bindings
;;=================================================================================

;; Switch frame window;
(global-set-key (kbd "s-<left>"  ) 'windmove-left)
(global-set-key (kbd "s-<right>" ) 'windmove-right)
(global-set-key (kbd "s-<up>"    ) 'windmove-up)
(global-set-key (kbd "s-<down>"  ) 'windmove-down)

;; default shell pop
(global-set-key (kbd "s-1") 'spacemacs/default-pop-shell)

;; comment functions
(defun agl-comment-and-go-down ()
  "Comments the current line and goes to the next one" (interactive)
  (condition-case nil (comment-region (point-at-bol) (point-at-eol)) (error nil))
  (end-of-line)
  (next-line 1)
  (back-to-indentation))
(defun agl-uncomment-and-go-up ()
  "Uncomments the current line and goes to the previous one" (interactive)
  (condition-case nil (uncomment-region (point-at-bol) (point-at-eol)) (error nil))
  (back-to-indentation)
  (next-line -1))

;; shift-down comments the current line and goes down
(define-key global-map [(shift down)] 'agl-comment-and-go-down)
;; shift-up uncomments the current line and goes up
(define-key global-map [(shift up)] 'agl-uncomment-and-go-up)


;; search functions
(defun agl-search-word-backward ()
  "Find the previous occurrence of the current word."
  (interactive)
  (let ((cur (point)))
    (skip-syntax-backward "w_")
    (goto-char
     (if (re-search-backward (concat "\\_<" (current-word) "\\_>") nil t)
         (match-beginning 0)
       cur))))

(defun agl-search-word-forward ()
  "Find the next occurrance of the current word."
  (interactive)
  (let ((cur (point)))
    (skip-syntax-forward "w_")
    (goto-char
     (if (re-search-forward (concat "\\_<" (current-word) "\\_>") nil t)
         (match-beginning 0)
       cur))))

(global-set-key '[(control meta up)]   'agl-search-word-backward)
(global-set-key '[(control meta down)] 'agl-search-word-forward)


(global-set-key (kbd "s-SPC" ) 'hippie-expand)

;; search in current directories
(global-set-key (kbd "s-O" ) 'spacemacs/helm-project-smart-do-search)
;; project setup
(global-set-key (kbd "s-b" ) 'projectile-switch-to-buffer)   ;; open buffer in another window
(global-set-key (kbd "s-o" ) 'projectile-find-file)   ;; find file in project
(global-set-key (kbd "s-`") 'projectile-find-other-file)   ;; jump to header
(global-set-key (kbd "<s-return>") 'spacemacs/jump-to-definition) ;; jump to definitions

;; function keys
;; (global-set-key '[(f1)] 'engine/search-google)             ;; search text in google
(global-set-key '[(f5)] 'projectile-compile-project)       ;; compile project

;; templates
(load "~/.spacemacs.d/local/template.el")
(require 'ni-templates)

;; org mode setup
(setq org-agenda-files '("~/Documents/Notes"))
(setq org-default-notes-file "~/Documents/Notes/notes.org")
(setq org-capture-templates
      (quote (
              ("t" "Todo" entry (file "~/Documents/Notes/tasks.org")
               "* TODO %?\n%U\n%a\n" :clock-in t :clock-resume t)
              ("r" "Respond" entry (file "~/Documents/Notes/notes.org")
               "* NEXT Respond to %:from on %:subject\nSCHEDULED: %t\n%U\n%a\n" :clock-in t :clock-resume t :immediate-finish t)
              ("n" "Note" entry (file "~/Documents/Notes/notes.org" "Notes")
               "* %? :NOTE:\n%T\n%a\n" :jump-to-captured)
              ("w" "org-protocol" entry (file "~/Documents/Notes/notes.org")
               "* TODO Review %c\n%U\n" :immediate-finish t)
              ("m" "Meeting" entry (file "~/Documents/Notes/notes.org")
               "* MEETING with %? :MEETING:\n%U" :clock-in t :clock-resume t)
              ("h" "Habit" entry (file "~/Documents/Notes/notes.org")
               "* NEXT %?\n%U\n%a\nSCHEDULED: %(format-time-string \"%<<%Y-%m-%d %a .+1d/3d>>\")\n:PROPERTIES:\n:STYLE: habit\n:REPEAT_TO_STATE: NEXT\n:END:\n")
              )))

(require 'org-projectile)
(push (org-projectile-project-todo-entry) org-capture-templates)
;; (setq org-agenda-files (append org-agenda-files (org-projectile-todo-files)))
(setq org-projectile-capture-template "*** TODO %?\n %i\n %a")
(add-to-list 'org-capture-templates
             (org-projectile-project-todo-entry
              :capture-character "l"
              :capture-heading "Linked Project TODO"))

;; If you would like a TODO entry to automatically change to DONE when all children are done, you can use the following setup:
(defun org-summary-todo (n-done n-not-done)
  "Switch entry to DONE when all subentries are done, to TODO otherwise."
  (let (org-log-done org-log-states)   ; turn off logging
    (org-todo (if (= n-not-done 0) "DONE" "TODO"))))

(add-hook 'org-after-todo-statistics-hook 'org-summary-todo)


;; (setenv "PATH" (concat (getenv "PATH") ":/home/zhangxun.zx/bin/"))
;; (add-to-list 'tramp-remote-path "/bin:/usr/bin:/opt/repo-alibaba/bin/:~/bin"):

;; (require 'flycheck-objc-clang) ; Not necessary if using ELPA package
;; (with-eval-after-load 'flycheckeck-objc-clang-setup))

;; (eval-after-load 'flycheck '(flycheck-swift-setup))
;; (setq flycheck-swift-sdk-path "/Applications/Xcode-beta.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS11.0.sdk")
;; Select the appropriate SDK version you use
;; (setq flycheck-swift-target "arm64-apple-ios11")

;; flycheck setup

;; (setq tab-always-indent 'complete)
(global-company-mode t)
;; Change the default hippie-expand order and add yasnippet to the front.
;; (setq hippie-expand-try-functions-list
;; '(yas/hippie-try-expand))

;; function to implement a smarter TAB (EmacsWiki)
(defun smart-tab ()
  "This smart tab is minibuffer compliant: it acts as usual in
    the minibuffer. Else, if mark is active, indents region. Else if
    point is at the end of a symbol, expands it. Else indents the
    current line."
  (interactive)
  (if (minibufferp)
      (unless (minibuffer-complete)
        (hippie-expand nil))
    (if mark-active
        (indent-region (region-beginning)
                       (region-end))
      (if (looking-at "\\_>")
          (hippie-expand nil)
        (indent-for-tab-command)))))
(global-set-key (kbd "TAB") 'smart-tab)

;; (global-set-key (kbd "M-/") 'yas-hippie-try-expand)

(defun setup-flycheck-clang-project-path ()
  (let ((root (ignore-errors (projectile-project-root))))
    (when root
      (add-to-list
       (make-variable-buffer-local 'flycheck-clang-include-path)
       root))))

(add-hook 'c++-mode-hook 'setup-flycheck-clang-project-path)
