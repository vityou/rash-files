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


; ls aliases
alias ls = 'exa
alias la = ls -a
alias ll = ls -la
alias l = ls -l


