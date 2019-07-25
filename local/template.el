(provide 'ni-templates)

;;;======================================================================
;;; Template
;;;======================================================================
;; (setenv "HAM_HOME" "/Users/Arantir/Work/ham/")
;; (add-to-list 'load-path (concat (getenv "HAM_HOME") "/sources/emacs"))

(defun agl-bash-cmd-to-string (aCmd)
  (shell-command-to-string aCmd))

(defun agl-uuid1 ()
  "Generate a type 1 UUID and return it."
  (interactive)
  (agl-bash-cmd-to-string "genuuid 1"))
(defun agl-uuid2 ()
  "Generate a type 2 UUID and return it."
  (interactive)
  (agl-bash-cmd-to-string "genuuid 2"))
(defun agl-uuid3 ()
  "Generate a type 3 UUID and return it."
  (interactive)
  (agl-bash-cmd-to-string "genuuid 3"))

(defun agl-uuid1-to-buffer ()
  "Generate a type 1 UUID and copy it in the clipboard."
  (interactive)
  (insert (agl-uuid1)))
(defun agl-uuid2-to-buffer ()
  "Generate a type 2 UUID and copy it in the clipboard."
  (interactive)
  (insert (agl-uuid2)))
(defun agl-uuid3-to-buffer ()
  "Generate a type 3 UUID and copy it in the clipboard."
  (interactive)
  (insert (agl-uuid3)))

(defun tpl-cpp-guards ()
  (interactive)
  (let ((GUARD (replace-regexp-in-string
                "\\."
                "_"
                (upcase (concat "__" (buffer-name) "_" (agl-uuid3) "__"))
                )))
    (beginning-of-buffer)
    (insert "#pragma once") (newline)
    (insert (concat "#ifndef " GUARD)) (newline)
    (insert (concat "#define " GUARD)) (newline)
    (end-of-buffer)
    (insert (concat "#endif // " GUARD)) (newline)
    ))
