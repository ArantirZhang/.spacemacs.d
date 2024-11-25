(setq explicit-shell-file-name "/bin/bash") ;; setup default shell
(setq evil-undo-system 'undo-redo)
(evil-set-undo-system 'undo-redo)

(global-so-long-mode 1)
(mouse-wheel-mode -1)
;; (beacon-mode 1)
(toggle-scroll-bar -1)
(setq bidi-paragraph-direction 'left-to-right)
(setq bidi-inhibit-bpa t)
(setq recenter-redisplay nil) ;; fixed a screen blinking issue on macOS
(setq no-redraw-on-reenter nil)
;; (setq global-auto-revert-mode nil)
;; disable mouse ==================================================================================
;; (load "~/.spacemacs.d/local/disable-mouse.el")
;; (require 'disable-mouse)
;; (global-disable-mouse-mode)
;; (mapc #'disable-mouse-in-keymap
      ;; (list evil-motion-state-map
            ;; evil-normal-state-map
            ;; evil-visual-state-map
            ;; evil-insert-state-map))
;; (setq mouse-avoidance-mode 'banish)
;; Enabling only some features
(require 'dap-cpptools)
;; (require 'dap-lldb)
(defun duplicate-line (arg)
  "Duplicate current line, leaving point in lower line."
  (interactive "*p")

  ;; save the point for undo
  (setq buffer-undo-list (cons (point) buffer-undo-list))

  ;; local variables for start and end of line
  (let ((bol (save-excursion (beginning-of-line) (point)))
        eol)
    (save-excursion

      ;; don't use forward-line for this, because you would have
      ;; to check whether you are at the end of the buffer
      (end-of-line)
      (setq eol (point))

      ;; store the line and disable the recording of undo information
      (let ((line (buffer-substring bol eol))
            (buffer-undo-list t)
            (count arg))
        ;; insert the line arg times
        (while (> count 0)
          (newline)         ;; because there is no newline in 'line'
          (insert line)
          (setq count (1- count)))
        )

      ;; create the undo information
      (setq buffer-undo-list (cons (cons eol (point)) buffer-undo-list)))
    ) ; end-of-let

  ;; put the point in the lowest line and return
  (next-line arg))

(global-set-key (kbd "s-D") 'kill-whole-line)
(global-set-key (kbd "s-d") 'duplicate-line)

(defun align-repeat (start end regexp)
  "Repeat alignment with respect to
     the given regular expression."
  (interactive "r\nsAlign regexp: ")
  (align-regexp start end
                (concat "\\(\\s-*\\)" regexp) 1 1 t))

(defun align-repeat0 (start end regexp)
  "Repeat alignment with respect to
     the given regular expression."
  (interactive "r\nsAlign regexp: ")
  (align-regexp start end
                (concat "\\(\\s-*\\)" regexp) 1 0 t))

;; company mode ===================================================================================
(global-company-mode t)
(setq company-dabbrev-downcase nil) ;; don't use downcase mode
(setq company-idle-delay 0) ;; No delay in showing suggestions.
(setq company-minimum-prefix-length 1) ;; Show suggestions after entering one character.

;; using tab to complete
(eval-after-load 'company
  '(progn
     (define-key company-active-map (kbd "TAB") 'company-complete-selection)
     (define-key company-active-map (kbd "<tab>") 'company-complete-selection)))
;; company mode ===================================================================================

(global-set-key [mouse-movement] 'ignore)
(show-paren-mode nil) ;; disable the paren-mode to get rid of the lag, and is not working well with multi-cursor
(show-smartparens-global-mode -1) ;; prevents show-smartparens-mode from "infiltrating" major modes which didn't ask for it
(electric-indent-mode 0) ;; electric-indent-mode disabled, it sometimes break my code
(ido-mode -1) ;; disable ido mode
(setq-default spacemacs-yank-indent-threshold 0) ;; disable intent
(setq-default ns-pop-up-frames nil) ;; Keep only one instance of emacs running

;; Keep the Chinese character the same size as English character
;; (dolist (charset '(kana han cjk-misc bopomofo))
  ;; (set-fontset-font (frame-parameter nil 'font) charset
                    ;; (font-spec :family "SimHei" :size 10)))


(setq create-lockfiles nil) ;; ignore warning "recentf mode: Non-character input-event"
(delete-selection-mode 1) ;; Replace the selected text when copy & parse
(setq make-backup-files nil) ; stop creating backup~ files
(setq auto-save-default nil) ; stop creating #autosave# files

;; this fixed the issue that the helm will always keep only windows in spacemacs.
(setq helm-always-two-windows nil)

;;(require 'helm-config)
;;(require 'helm-autoloads)
(helm-mode 1)
(define-key helm-map (kbd "<right>") 'helm-execute-persistent-action)
(define-key helm-map (kbd "<left>") 'helm-find-files-up-one-level)

(define-key helm-find-files-map (kbd "s-c") 'helm-ff-run-copy-file)
(define-key helm-find-files-map (kbd "s-d") 'helm-ff-run-delete-file)
(define-key helm-find-files-map (kbd "s-r") 'helm-ff-run-rename-file)
(define-key helm-find-files-map (kbd "s-l") 'helm-ff-run-symlink-file)
;; (define-key helm-find-files-map (kbd "s-t") 'helm-ff-run-touch-files)
;; (define-key helm-map (kbd "") 'helm-ff-run-hardlink-file)
;; (define-key helm-map (kbd "") 'helm-ff-run-kill-buffer-persistent)
;; (define-key helm-map (kbd "") 'helm-ff-run-load-file)

;; Dired setup
(require 'dired)
(setq dired-dwim-target t)                     ;; Enable copyd
(add-hook 'dired-mode-hook
          (lambda ()
            (define-key dired-mode-map (kbd "<left>")
              (lambda () (interactive) (find-alternate-file "..")))))
(define-key dired-mode-map (kbd "<right>") 'dired-find-alternate-file) ;; dired-view-file
;; (define-key dired-mode-map (kbd "<left>") 'dired-up-directory) ;; dired-up-directory

;; Elixir alchemist setup
;; (require 'alchemist)
;; (define-key elixir-mode-map (kbd "s-r") 'alchemist-iex-compile-this-buffer-and-go)
;; (define-key alchemist-iex-mode-map (kbd "s-;") 'alchemist-iex-clear-buffer)

;; (eval-after-load 'flycheck
  ;; '(flycheck-credo-setup))
;; (add-hook 'elixir-mode-hook 'flycheck-mode)
;; (setq flycheck-elixir-credo-strict t)

;; (require 'flycheck-mix)
;; (flycheck-mix-setup)


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

(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
;; (setq web-mode-markup-indent-offset 2)
;; nxml-mode
(setq
 web-mode-markup-indent-offset 2
 web-mode-css-indent-offset 2
 web-mode-code-indent-offset 2
 web-mode-attr-indent-offset 2)

(setq nxml-child-indent 2 nxml-attribute-indent 2)

(setq sh-indentation 2)

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

(setq c-default-style
      '((java-mode . "Arantir")
        (awk-mode . "awk")
        (other . "Arantir")))

;; lsp mode setup, doc frame and sideline is disabled

(setq-default lsp-ui-doc-enable t)
;; (setq-default lsp-headerline-breadcrumb-enable nil)
(setq-default lsp-ui-sideline-enable t)
(setq-default lsp-ui-sideline-show-code-actions t)
(setq-default lsp-before-save-edits nil)
(setq-default lsp-highlight-symbol-at-point nil)
(setq-default lsp-enable-symbol-highlighting nil)
(setq-default lsp-enable-indentation nil)
(setq-default lsp-enable-on-type-formatting nil)
(setq-default lsp-enable-folding nil)
(setq-default lsp-enable-file-watchers nil)
(setq-default lsp-enable-links nil)

(with-eval-after-load 'lsp-mode
  (define-key lsp-mode-map (kbd "s-r") 'lsp-ui-sideline-apply-code-actions))
(setq-default lsp-java-import-gradle-enabled t)

;; (setq-default lsp-enable-completion-at-point nil)
;; (setq-default lsp-java-save-action-organize-imports nil)

;; hlsl
(load "~/.spacemacs.d/local/hlsl-model.el")
(add-to-list 'auto-mode-alist '("\\.cgh\\'" . hlsl-mode))
(add-to-list 'auto-mode-alist '("\\.cgc\\'" . hlsl-mode))
(autoload 'hlsl-mode "hlsl" nil t)

;; niscript
(load "~/.spacemacs.d/local/niscript.el")
(add-to-list 'auto-mode-alist '("\\.ni\\'" . niscript-mode))
(add-to-list 'auto-mode-alist '("\\.nip\\'" . niscript-mode))
(add-to-list 'auto-mode-alist '("\\.niw\\'" . niscript-mode))
(add-to-list 'auto-mode-alist '("\\.nil\\'" . niscript-mode))
(add-to-list 'auto-mode-alist '("\\.nit\\'" . niscript-mode))
(add-to-list 'auto-mode-alist '("\\.niui\\'" . web-mode))
(autoload 'niscript-mode "niScript" nil t)

(load "~/.spacemacs.d/local/hamfile.el")
(autoload 'ham-mode "hamfile" nil t)

(add-to-list 'auto-mode-alist '("\\.ham\\'" . ham-mode))
(add-to-list 'auto-mode-alist '("\\Jamfile\\'" . ham-mode))
(add-to-list 'auto-mode-alist '("\\Jamrules\\'" . ham-mode))
(add-to-list 'auto-mode-alist '("\\Jambase\\'" . ham-mode))
(add-to-list 'auto-mode-alist '("\\Hamfile\\'" . ham-mode))
(add-to-list 'auto-mode-alist '("\\Hamrules\\'" . ham-mode))
(add-to-list 'auto-mode-alist '("\\Hambase\\'" . ham-mode))

;; (setq default-tab-width 2) ;; set default tab to 2
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode)) ;; load all .h file as c++ header
(add-to-list 'auto-mode-alist '("\\.cni\\'" . c++-mode)) ;; load all .cni file as c++
(add-to-list 'auto-mode-alist '("\\.inl\\'" . c++-mode)) ;; load all .inl file as c++
(add-to-list 'auto-mode-alist '("\\.mm\\'" . c++-mode)) ;; load all .mm file as objective-c file

(add-to-list 'auto-mode-alist '("\\.xml\\'" . xml-mode)) 
(add-to-list 'auto-mode-alist '("\\.XML\\'" . xml-mode)) 

(with-eval-after-load ' projectile
  (push '("C" "h") projectile-other-file-alist))

;; js setup
(setq-default js2-basic-offset 2
              js-indent-level 2)

(setq-default web-mode-markup-indent-offset 2)
(setq-default web-mode-css-indent-offset 2)

;; swift
(setq-default swift-mode:basic-offset 2)

;; (require 'company-sourcekit)
;; (add-to-list 'company-backends 'company-sourcekit)
;; (setq-default company-sourcekit-use-yasnippet nil)
;; (setq-default sourcekit-verbose 1)
;; (setq-default company-sourcekit-verbose 1)

;;=================================================================================
;;                       inline-string-rectangle
;;=================================================================================

(global-set-key (kbd "M-<down>") 'mc/mark-next-like-this)
(global-set-key (kbd "M-<up>") 'mc/unmark-next-like-this)
(global-set-key (kbd "M-S-<down>") 'mc/skip-to-next-like-this)
;; (global-set-key (kbd "M-S-<up>") 'mc/skip-to-previous-like-this)


(global-set-key (kbd "C-*") 'mc/mark-all-like-this)
(global-set-key (kbd "C-x r t") 'set-rectangular-region-anchor)

(defun mmc/increment-number-at-cursors (number)
  "Increment numbers for all cursors by NUMBER."
  (interactive (list (read-number "Input increment number: " 0)))
  (mc/insert-numbers number)
  )

(defun mmc/increment-letter-at-cursors (letter)
  "Insert increasing letters for each cursor, starting at 0 or ARG.
     Where letter[0]=a letter[2]=c letter[26]=aa"
  (interactive (list (read-number "Input increment letter where [0]=a [26]=aa : " 0)))
  (mc/insert-letters letter)
  )

(with-eval-after-load 'multiple-cursors-core
  (define-key mc/keymap (kbd "M-s-<down>") 'mmc/increment-number-at-cursors)
  (define-key mc/keymap (kbd "M-s-<up>") 'mmc/increment-letter-at-cursors)
  )

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


(defun align-repeat (start end regexp)
  "Repeat alignment with respect to
     the given regular expression."
  (interactive "r\nsAlign regexp: ")
  (align-regexp start end
                (concat "\\(\\s-*\\)" regexp) 1 1 t))

(defun align-repeat0 (start end regexp)
  "Repeat alignment with respect to
     the given regular expression."
  (interactive "r\nsAlign regexp: ")
  (align-regexp start end
                (concat "\\(\\s-*\\)" regexp) 1 0 t))


;; Switch frame window;
(global-set-key (kbd "s-<left>"  ) 'windmove-left)
(global-set-key (kbd "s-<right>" ) 'windmove-right)
(global-set-key (kbd "s-<up>"    ) 'windmove-up)
(global-set-key (kbd "s-<down>"  ) 'windmove-down)
(global-set-key (kbd "s-e") 'align-repeat0)
(global-set-key (kbd "s-E") 'align-repeat)

;; default shell pop
;; (global-set-key (kbd "s-1") 'spacemacs/default-pop-shell)

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
(global-set-key (kbd "s-i" ) 'spacemacs/helm-dir-do-ag)
(global-set-key (kbd "s-I" ) 'spacemacs/helm-do-ag)
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


;; (load "~/.spacemacs.d/local/fan-mode_bak.el")
;; (require 'fan-mode)
;; (add-to-list 'auto-mode-alist '("\\.fan\\'" . fan-mode))

;; (defun my-font-lock-comment-annotations ()
  ;; "Highlight text between backticks in comments."
  ;; (font-lock-add-keywords
   ;; nil
   ;; '(("\\<\\(`\\)\\(\\(?:\\(?:[^`\\]\\|\\\\.\\)*\\)\\(`\\)\\)\\>" 2 font-lock-string-face t))))

;; (add-hook 'fan-mode-hook 'my-font-lock-comment-annotations)

;; (add-hook 'fan-mode-hook
          ;; (lambda ()
            ;; (font-lock-add-keywords nil
                                    ;; '(("`" . font-lock-constant-face)
                                      ;; ("`" . font-lock-constant-face)))))

            ;; (font-lock-add-keywords nil '(("\\*\\*+.*$" . font-lock-comment-face)))))
            ;; (font-lock-add-keywords nil '(("\\(\\*\\*\\)\\(.*\\)$" 2 font-lock-comment-face t)))))


;; ;; org mode setup

;; (setq org-agenda-files '("~/Documents/Notes"))
;; (setq org-default-notes-file "~/Documents/Notes/notes.org")
;; (setq org-capture-templates
      ;; (quote (
              ;; ("t" "Todo" entry (file "~/Documents/Notes/tasks.org")
               ;; "* TODO %?\n%U\n%a\n" :clock-in t :clock-resume t)
              ;; ("r" "Respond" entry (file "~/Documents/Notes/notes.org")
               ;; "* NEXT Respond to %:from on %:subject\nSCHEDULED: %t\n%U\n%a\n" :clock-in t :clock-resume t :immediate-finish t)
              ;; ("n" "Note" entry (file "~/Documents/Notes/notes.org" "Notes")
               ;; "* %? :NOTE:\n%T\n%a\n" :jump-to-captured)
              ;; ("w" "org-protocol" entry (file "~/Documents/Notes/notes.org")
               ;; "* TODO Review %c\n%U\n" :immediate-finish t)
              ;; ("m" "Meeting" entry (file "~/Documents/Notes/notes.org")
               ;; "* MEETING with %? :MEETING:\n%U" :clock-in t :clock-resume t)
              ;; ("h" "Habit" entry (file "~/Documents/Notes/notes.org")
               ;; "* NEXT %?\n%U\n%a\nSCHEDULED: %(format-time-string \"%<<%Y-%m-%d %a .+1d/3d>>\")\n:PROPERTIES:\n:STYLE: habit\n:REPEAT_TO_STATE: NEXT\n:END:\n")
              ;; )))

;; (setf org-adapt-indentation t)
;; (require 'org-projectile)
;; (push (org-projectile-project-todo-entry) org-capture-templates)
;; (setq org-agenda-files (append org-agenda-files (org-projectile-todo-files)))
;; (setq org-projectile-capture-template "*** TODO %?\n %i\n %a")
;; (add-to-list 'org-capture-templates
             ;; (org-projectile-project-todo-entry
              ;; :capture-character "l"
              ;; :capture-heading "Linked Project TODO"))

;; ;; If you would like a TODO entry to automatically change to DONE when all children are done, you can use the following setup:
;; (defun org-summary-todo (n-done n-not-done)
  ;; "Switch entry to DONE when all subentries are done, to TODO otherwise."
  ;; (let (org-log-done org-log-states)   ; turn off logging
    ;; (org-todo (if (= n-not-done 0) "DONE" "TODO"))))

;; (add-hook 'org-after-todo-statistics-hook 'org-summary-todo)

;; ;; ;; ;; org mode setup


;; (setenv "PATH" (concat (getenv "PATH") ":/home/zhangxun.zx/bin/"))
;; (add-to-list 'tramp-remote-path "/bin:/usr/bin:/opt/repo-alibaba/bin/:~/bin"):

;; (customize-set-variable 'tramp-default-method "rsync")
;; (customize-set-variable 'tramp-copy-size-limit "rsync")

;; (require 'flycheck-objc-clang) ; Not necessary if using ELPA package
;; (with-eval-after-load 'flycheckeck-objc-clang-setup))

;; (eval-after-load 'flycheck '(flycheck-swift-setup))
;; (setq flycheck-swift-sdk-path "/Applications/Xcode-beta.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS11.0.sdk")
;; Select the appropriate SDK version you use
;; (setq flycheck-swift-target "arm64-apple-ios11")

;; flycheck setup

;; (setq tab-always-indent 'complete)

;; Change the default hippie-expand order and add yasnippet to the front.
;; (setq hippie-expand-try-functions-list
;; '(yas/hippie-try-expand))

;; tailwindcss enabled
(load "~/.spacemacs.d/local/lsp-tailwindcss.el")
(use-package lsp-tailwindcss
  :init
  (setq lsp-tailwindcss-add-on-mode t))

(global-set-key (kbd "s-1") 'open-current-file-external)

(load "~/.spacemacs.d/local/reveal-in-osx-finder.el")
(spacemacs/set-leader-keys "fd" 'reveal-in-osx-finder)
;; (global-set-key (kbd "s-R") 'reveal-in-osx-finder)

(defun open-current-file-external ()
  "Open the current file using the default external program."
  (interactive)
  (browse-url (buffer-file-name)))

(defun browse-file-directory ()
  "Open the current file's directory however the OS would."
  (interactive)
  (if default-directory
      (browse-url-of-file (expand-file-name default-directory))
    (error "No `default-directory' to open")))



(with-eval-after-load 'markdown-mode
  (unbind-key "M-<up>" 'markdown-mode-map)
  (unbind-key "M-<down>" 'markdown-mode-map)
  (unbind-key "M-<left>" 'markdown-mode-map)
  (unbind-key "M-<right>" 'markdown-mode-map))
