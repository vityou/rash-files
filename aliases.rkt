#lang rash

(require (for-syntax racket/base syntax/parse))

(provide (all-defined-out))


; allows defining aliases in the form:
; alias x = y
; or:
; alias x y

(define-line-macro alias
  (syntax-parser
    [(_ name:id (~optional (~datum =)) value:expr ...) #'(define-simple-pipeline-alias name value ...)]))


(define best-ls-command
  (if (string=? (substring (getenv "TERM") 0 5) "xterm")
      (cond
        [(find-executable-path "ls_extended") 'ls_extended]
        [(find-executable-path "exa") 'exa]
        [else "ls --color=auto"])
      "ls --color=auto"))


; ls aliases
alias ls = "$best-ls-command" ; the $ means look for a racket variable I believe
alias la = ls -a
alias ll = ls -la
alias l = ls -l


