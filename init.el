;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Configuration Layers declaration.
You should not put any user code in this function besides modifying the variable
values."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs
   ;; Lazy installation of layers (i.e. layers are installed only when a file
   ;; with a supported type is opened). Possible values are `all', `unused'
   ;; and `nil'. `unused' will lazy install only unused layers (i.e. layers
   ;; not listed in variable `dotspacemacs-configuration-layers'), `all' will
   ;; lazy install any layer that support lazy installation even the layers
   ;; listed in `dotspacemacs-configuration-layers'. `nil' disable the lazy
   ;; installation feature and you have to explicitly list a layer in the
   ;; variable `dotspacemacs-configuration-layers' to install it.
   ;; (default 'unused)
   dotspacemacs-enable-lazy-installation 'unused
   ;; If non-nil then Spacemacs will ask for confirmation before installing
   ;; a layer lazily. (default t)
   dotspacemacs-ask-for-lazy-installation t
   ;; If non-nil layers with lazy install support are lazy installed.
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()
   ;; List of configuration layers to load.
   dotspacemacs-configuration-layers
   '(
     ;; ----------------------------------------------------------------
     ;; Example of useful layers you may want to use right away.
     ;; Uncomment some layer names and press <SPC f e R> (Vim style) or
     ;; <M-m f e R> (Emacs style) to install them.
     ;; ----------------------------------------------------------------
     helm ;; the main completion

     ;; ------------------------- languages ----------------------------
     (c-c++ :variables
            c-c++-default-mode-for-headers 'c++-mode
            c-c++-enable-clang-support t)
     octave
     swift
     python
     yaml
     javascript
     java
     html
     emacs-lisp
     markdown
     elixir

     ;; -------------------------- coding -------------------------------
     auto-completion
     syntax-checking
     better-defaults
     gtags

     ;; --------------------------- tools -------------------------------
     dash
     search-engine
     git
     org
     (shell :variables
            shell-default-shell 'ansi-term
            shell-default-height 30
            shell-default-position 'bottom
            )
     ;; spell-checking
     ;; version-control
     )
   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages, then consider creating a layer. You can also put the
   ;; configuration in `dotspacemacs/user-config'.
   dotspacemacs-additional-packages '(
                                      flycheck-objc-clang
                                      flycheck-swift
                                      )
   ;; A list of packages that cannot be updated.
   dotspacemacs-frozen-packages '()
   ;; A list of packages that will not be installed and loaded.
   dotspacemacs-excluded-packages '()
   ;; Defines the behaviour of Spacemacs when installing packages.
   ;; Possible values are `used-only', `used-but-keep-unused' and `all'.
   ;; `used-only' installs only explicitly used packages and uninstall any
   ;; unused packages as well as their unused dependencies.
   ;; `used-but-keep-unused' installs only the used packages but won't uninstall
   ;; them if they become unused. `all' installs *all* packages supported by
   ;; Spacemacs and never uninstall them. (default is `used-only')
   dotspacemacs-install-packages 'used-only))

(defun dotspacemacs/init ()
  "Initialization function.
This function is called at the very startup of Spacemacs initialization
before layers configuration.
You should not put any user code in there besides modifying the variable
values."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; If non nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https t
   ;; Maximum allowed time in seconds to contact an ELPA repository.
   dotspacemacs-elpa-timeout 5
   ;; If non nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. Note that checking for
   ;; new versions works via git commands, thus it calls GitHub services
   ;; whenever you start Emacs. (default nil)
   dotspacemacs-check-for-update nil
   ;; If non-nil, a form that evaluates to a package directory. For example, to
   ;; use different package directories for different Emacs versions, set this
   ;; to `emacs-version'.
   dotspacemacs-elpa-subdirectory nil
   ;; One of `vim', `emacs' or `hybrid'.
   ;; `hybrid' is like `vim' except that `insert state' is replaced by the
   ;; `hybrid state' with `emacs' key bindings. The value can also be a list
   ;; with `:variables' keyword (similar to layers). Check the editing styles
   ;; section of the documentation for details on available variables.
   ;; (default 'vim)
   dotspacemacs-editing-style 'emacs
   ;; If non nil output loading progress in `*Messages*' buffer. (default nil)
   dotspacemacs-verbose-loading nil
   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner 'official
   ;; List of items to show in startup buffer or an association list of
   ;; the form `(list-type . list-size)`. If nil then it is disabled.
   ;; Possible values for list-type are:
   ;; `recents' `bookmarks' `projects' `agenda' `todos'."
   ;; List sizes may be nil, in which case
   ;; `spacemacs-buffer-startup-lists-length' takes effect.
   dotspacemacs-startup-lists '((recents . 5)
                                (projects . 7))
   ;; True if the home buffer should respond to resize events.
   dotspacemacs-startup-buffer-responsive t
   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'text-mode
   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press <SPC> T n to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(spacemacs-dark
                         spacemacs-light)
   ;; If non nil the cursor color matches the state color in GUI Emacs.
   dotspacemacs-colorize-cursor-according-to-state t
   ;; Default font, or prioritized list of fonts. `powerline-scale' allows to
   ;; quickly tweak the mode-line size to make separators look not too crappy.
   dotspacemacs-default-font '("Monaco"
                               :size 12
                               :weight normal
                               :width normal
                               :powerline-scale 1.1)
   ;; The leader key
   dotspacemacs-leader-key "SPC"
   ;; The key used for Emacs commands (M-x) (after pressing on the leader key).
   ;; (default "SPC")
   dotspacemacs-emacs-command-key "SPC"
   ;; The key used for Vim Ex commands (default ":")
   dotspacemacs-ex-command-key ":"
   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"
   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","
   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m")
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs C-i, TAB and C-m, RET.
   ;; Setting it to a non-nil value, allows for separate commands under <C-i>
   ;; and TAB or <C-m> and RET.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil
   ;; If non nil `Y' is remapped to `y$' in Evil states. (default nil)
   dotspacemacs-remap-Y-to-y$ nil
   ;; If non-nil, the shift mappings `<' and `>' retain visual state if used
   ;; there. (default t)
   dotspacemacs-retain-visual-state-on-shift t
   ;; If non-nil, J and K move lines up and down when in visual mode.
   ;; (default nil)
   dotspacemacs-visual-line-move-text nil
   ;; If non nil, inverse the meaning of `g' in `:substitute' Evil ex-command.
   ;; (default nil)
   dotspacemacs-ex-substitute-global nil
   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"
   ;; If non nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil
   ;; If non nil then the last auto saved layouts are resume automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil
   ;; Size (in MB) above which spacemacs will prompt to open the large file
   ;; literally to avoid performance issues. Opening a file literally means that
   ;; no major mode or minor modes are active. (default is 1)
   dotspacemacs-large-file-size 10
   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location nil
   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 5
   ;; If non nil, `helm' will try to minimize the space it uses. (default nil)
   dotspacemacs-helm-resize nil
   ;; if non nil, the helm header is hidden when there is only one source.
   ;; (default nil)
   dotspacemacs-helm-no-header nil
   ;; define the position to display `helm', options are `bottom', `top',
   ;; `left', or `right'. (default 'bottom)
   dotspacemacs-helm-position 'bottom
   ;; Controls fuzzy matching in helm. If set to `always', force fuzzy matching
   ;; in all non-asynchronous sources. If set to `source', preserve individual
   ;; source settings. Else, disable fuzzy matching in all sources.
   ;; (default 'always)
   dotspacemacs-helm-use-fuzzy 'always
   ;; If non nil the paste micro-state is enabled. When enabled pressing `p`
   ;; several times cycle between the kill ring content. (default nil)
   dotspacemacs-enable-paste-transient-state nil
   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0
   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom
   ;; If non nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t
   ;; If non nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil
   ;; If non nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native t
   ;; If non nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup nil
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90
   ;; If non nil show the titles of transient states. (default t)
   dotspacemacs-show-transient-state-title t
   ;; If non nil show the color guide hint for transient state keys. (default t)
   dotspacemacs-show-transient-state-color-guide t
   ;; If non nil unicode symbols are displayed in the mode line. (default t)
   dotspacemacs-mode-line-unicode-symbols t
   ;; If non nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters point
   ;; when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling nil
   ;; Control line numbers activation.
   ;; If set to `t' or `relative' line numbers are turned on in all `prog-mode' and
   ;; `text-mode' derivatives. If set to `relative', line numbers are relative.
   ;; This variable can also be set to a property list for finer control:
   ;; '(:relative nil
   ;;   :disabled-for-modes dired-mode
   ;;                       doc-view-mode
   ;;                       markdown-mode
   ;;                       org-mode
   ;;                       pdf-view-mode
   ;;                       text-mode
   ;;   :size-limit-kb 1000)
   ;; (default nil)
   dotspacemacs-line-numbers nil
   ;; Code folding method. Possible values are `evil' and `origami'.
   ;; (default 'evil)
   dotspacemacs-folding-method 'evil
   ;; If non-nil smartparens-strict-mode will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil
   ;; If non-nil pressing the closing parenthesis `)' key in insert mode passes
   ;; over any automatically added closing parenthesis, bracket, quote, etc…
   ;; This can be temporary disabled by pressing `C-q' before `)'. (default nil)
   dotspacemacs-smart-closing-parenthesis nil
   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all
   ;; If non nil, advise quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil
   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `ag', `pt', `ack' and `grep'.
   ;; (default '("ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("ag" "pt" "ack" "grep")
   ;; The default package repository used if no explicit repository has been
   ;; specified with an installed package.
   ;; Not used for now. (default nil)
   dotspacemacs-default-package-repository nil
   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed'to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup 'trailing
   ))

(defun dotspacemacs/user-init ()
  "Initialization function for user code.
It is called immediately after `dotspacemacs/init', before layer configuration
executes.
 This function is mostly useful for variables that need to be set
before packages are loaded. If you are unsure, you should try in setting them in
`dotspacemacs/user-config' first."

  ;; Set default environment path here
  (setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))
  (setq exec-path (append exec-path '("/usr/local/bin")))
  )

(defun dotspacemacs/user-config ()
  "Configuration function for user code.
This function is called at the very end of Spacemacs initialization after
layers configuration.
This is the place where most of your configurations should be done. Unless it is
explicitly specified that a variable should be set before a package is loaded,
you should place your code here."

  ;; Keep only one instance of emacs running
  (setq-default ns-pop-up-frames nil)

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
  (add-to-list 'auto-mode-alist '("\\.cni\\'" . c++-mode)) ;; load all .h file as c++ header
  (add-to-list 'auto-mode-alist '("\\.mm\\'" . objc-mode)) ;; load all .mm file as objective-c file

  (with-eval-after-load ' projectile
    (push '("C" "h") projectile-other-file-alist))

  ;; js setup
  (setq-default js2-basic-offset 2
                js-indent-level 2)

  ;; swift
  (setq-default swift-mode:basic-offset 2)

  ;; java
  (add-hook 'java-mode-hook (lambda ()
                              (setq c-basic-offset 2)))
  (setq eclim-eclipse-dirs "/Applications/Eclipse.app/Contents/Eclipse"
        eclim-executable "/Applications/Eclipse.app/Contents/Eclipse/eclim"
        eclimd-executable "/Applications/Eclipse.app/Contents/Eclipse/eclimd"
        eclimd-default-workspace "~/Work/projects")
  ;; (setq eclim-auto-save nil)


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
  (global-set-key (kbd "s-b" ) 'projectile-switch-to-buffer-other-window)   ;; open buffer in another window
  (global-set-key (kbd "s-o" ) 'projectile-find-file-other-window)   ;; find file in project
  (global-set-key (kbd "s-`") 'projectile-find-other-file)   ;; jump to header
  (global-set-key (kbd "<s-return>") 'spacemacs/jump-to-definition-other-window) ;; jump to definitions
  ;; (global-set-key (kbd "<s-return>") 'spacemacs/jump-to-definition) ;; jump to definitions

  ;; function keys
  (global-set-key '[(f1)] 'engine/search-google)             ;; search text in google
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
                ("j" "Journal" entry (file+datetree "~/git/org/diary.org")
                 "* %?\n%U\n" :clock-in t :clock-resume t)
                ("w" "org-protocol" entry (file "~/Documents/Notes/notes.org")
                 "* TODO Review %c\n%U\n" :immediate-finish t)
                ("m" "Meeting" entry (file "~/Documents/Notes/notes.org")
                 "* MEETING with %? :MEETING:\n%U" :clock-in t :clock-resume t)
                ("p" "Phone call" entry (file "~/Documents/Notes/notes.org")
                 "* PHONE %? :PHONE:\n%U" :clock-in t :clock-resume t)
                ("h" "Habit" entry (file "~/Documents/Notes/notes.org")
                 "* NEXT %?\n%U\n%a\nSCHEDULED: %(format-time-string \"%<<%Y-%m-%d %a .+1d/3d>>\")\n:PROPERTIES:\n:STYLE: habit\n:REPEAT_TO_STATE: NEXT\n:END:\n"))))

  ;; (setenv "PATH" (concat (getenv "PATH") ":/home/zhangxun.zx/bin/"))
  ;; (add-to-list 'tramp-remote-path "/bin:/usr/bin:/opt/repo-alibaba/bin/:~/bin"):

  ;; (require 'flycheck-objc-clang) ; Not necessary if using ELPA package
  ;; (with-eval-after-load 'flycheckeck-objc-clang-setup))

  (eval-after-load 'flycheck '(flycheck-swift-setup))
  (setq flycheck-swift-sdk-path "/Applications/Xcode-beta.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS11.0.sdk")
  ;; Select the appropriate SDK version you use
  (setq flycheck-swift-target "arm64-apple-ios11")

  ;; flycheck setup
  (global-company-mode t)

  ;; (setq tab-always-indent 'complete)
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

  )

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (xterm-color unfill smeargle shell-pop orgit org-projectile org-category-capture org-present org-pomodoro alert log4e gntp org-mime org-download ob-elixir mwim multi-term mmm-mode markdown-toc markdown-mode magit-gitflow htmlize helm-gtags helm-gitignore gnuplot gitignore-mode gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link gh-md ggtags flycheck-swift flycheck-objc-clang flycheck-mix flycheck-credo evil-magit magit magit-popup git-commit ghub with-editor eshell-z eshell-prompt-extras esh-help disaster company-c-headers cmake-mode clang-format alchemist elixir-mode yapfify yaml-mode web-mode web-beautify tagedit swift-mode slim-mode scss-mode sass-mode pyvenv pytest pyenv-mode py-isort pug-mode pip-requirements livid-mode skewer-mode simple-httpd live-py-mode less-css-mode json-mode json-snatcher json-reformat js2-refactor multiple-cursors js2-mode js-doc hy-mode helm-pydoc helm-dash helm-css-scss helm-company helm-c-yasnippet haml-mode fuzzy flycheck-pos-tip pos-tip flycheck engine-mode emmet-mode dash-at-point cython-mode company-web web-completion-data company-tern dash-functional tern company-statistics company-emacs-eclim eclim company-anaconda company coffee-mode auto-yasnippet yasnippet anaconda-mode pythonic ac-ispell auto-complete ws-butler winum which-key volatile-highlights vi-tilde-fringe uuidgen use-package toc-org spaceline restart-emacs request rainbow-delimiters popwin persp-mode pcre2el paradox org-plus-contrib org-bullets open-junk-file neotree move-text macrostep lorem-ipsum linum-relative link-hint indent-guide hungry-delete hl-todo highlight-parentheses highlight-numbers highlight-indentation helm-themes helm-swoop helm-projectile helm-mode-manager helm-make helm-flx helm-descbinds helm-ag google-translate golden-ratio flx-ido fill-column-indicator fancy-battery eyebrowse expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-search-highlight-persist evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-lisp-state evil-indent-plus evil-iedit-state evil-exchange evil-escape evil-ediff evil-args evil-anzu eval-sexp-fu elisp-slime-nav dumb-jump diminish define-word column-enforce-mode clean-aindent-mode auto-highlight-symbol auto-compile aggressive-indent adaptive-wrap ace-window ace-link ace-jump-helm-line))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
