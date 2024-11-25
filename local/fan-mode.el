(setq fan-font-lock-keywords
      (let* (
             ;; define several category of keywords
             (x-keywords '("using" "class" "return" "continue" "break" "abstract" "final" "const" "private" "protected" "internal" "public" "static" "synchronized" "virtual" "override" "once" "new"))
             (x-types '("Obj" "Str" "Int" "Decimal" "Uri" "Bool" "Void" "Weekday" "DateTime" "Duration" "Enum" "Field" "Float" "List" "Map" "Method" "Month" "Range" "Slot"))
             (x-constants '("ACTIVE" "AGENT" "ALL_SIDES" "ATTACH_BACK"))
             (x-events '("at_rot_target" "at_target" "attach"))
             (x-functions '("llAbs" "llAcos" "llAddToLandBanList" "llAddToLandPassList"))

             ;; generate regex string for each category of keywords
             (x-keywords-regexp (regexp-opt x-keywords 'words))
             (x-types-regexp (regexp-opt x-types 'words))
             (x-constants-regexp (regexp-opt x-constants 'words))
             (x-events-regexp (regexp-opt x-events 'words))
             (x-functions-regexp (regexp-opt x-functions 'words)))

        `(
          (,x-types-regexp . 'font-lock-type-face)
          (,x-constants-regexp . 'font-lock-constant-face)
          (,x-events-regexp . 'font-lock-builtin-face)
          (,x-functions-regexp . 'font-lock-function-name-face)
          (,x-keywords-regexp . 'font-lock-keyword-face)
          ;; note: order above matters, because once colored, that part won't change.
          ;; in general, put longer words first
          )))


;;;###autoload
(define-derived-mode fan-mode c-mode "Fan"
  "Major mode for editing LSL (Linden Scripting Language)…"

  (setq-local comment-start "**")
  (setq-local comment-start-skip "\\*\\*+[ \t]*")
  (setq-local comment-end "")

  ;; code for syntax highlighting
  (setq font-lock-defaults '((fan-font-lock-keywords))))
;; add the mode to the `features' list
(provide 'fan-mode)

;; fan-mode.el ends here

;; (define-generic-mode 
;; 'foo-mode                         ;; name of the mode to create
;; '("!!")                           ;; comments start with '!!'
;; '("account" "user" 
;; "password")                     ;; some keywords
;; '(("=" . 'font-lock-operator)     ;; '=' is an operator
;; (";" . 'font-lock-builtin))     ;; ';' is a built-in 
;; '("\\.foo$")                      ;; files for which to activate this mode 
;; nil                              ;; other functions to call
;; "A mode for foo files"            ;; doc string for this mode
;; )
