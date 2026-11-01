;; -*- lexical-binding: t; -*-

;; Define highlighting rules
(defconst mgs-keywords
  '("func" "struct" "return" "var" "if" "else")
  "All the keywords in the mgs language")

(defconst mgs-constants
  '("true" "false")
  "All the constant values that can be defined in mgs")

(defconst mgs-builtin-types
  '("i8" "i16" "i32" "i64" "bool" "void")
  "All the builtin types supported by mgs")

(defconst mgs-identifier-regexp "\\_<[a-zA-Z_][a-zA-Z0-9_]*\\_>"
  "Regexp matching an mgs identifier.")

(defconst mgs-font-lock
  (list
   (cons (regexp-opt mgs-keywords 'symbols) 'font-lock-keyword-face)
   (cons (regexp-opt mgs-constants 'symbols) 'font-lock-constant-face)
   ;; Regex for user defined struct types
   (list (concat "\\(" mgs-identifier-regexp "\\)\\s-*:\\s-*struct\\_>")
         1 'font-lock-type-face)
   ;; Regex for user defined function types
   (list (concat "\\(" mgs-identifier-regexp "\\)\\s-*:\\s-*func\\s-*(")
         1 'font-lock-function-name-face)
   ;; Anything identifier after a colon is treated as a type (with optional var keyword)
   (list (concat ":\\s-*\\(?:var\\s-+\\)?\\(" mgs-identifier-regexp "\\)")
      1 'font-lock-type-face)
   (cons (regexp-opt mgs-builtin-types 'symbols) 'font-lock-type-face)
   (cons mgs-identifier-regexp 'font-lock-variable-name-face))
  "Highlighting rules for the mgs programming language.")

;; Define the syntax table
(defvar mgs-mode-syntax-table
  (let ((table (make-syntax-table)))
    (modify-syntax-entry ?- ". 12" table)
    (modify-syntax-entry ?\n ">" table)
    table)
  "Syntax table for `mgs-mode'.")

;; Build the major mode
(define-derived-mode mgs-mode prog-mode "MGS"
  "Major mode for working with mgs files."
  :syntax-table mgs-mode-syntax-table
  (setq-local font-lock-defaults '(mgs-font-lock))
  (setq-local comment-start "-- ")
  (setq-local comment-end   ""))

;; Autoload for .mgs files
(add-to-list 'auto-mode-alist '("\\.mgs\\'" . mgs-mode))

;; Expose the mode for users
(provide 'mgs-mode)
;;; mgs-mode.el ends here
