#lang rash

(require (for-syntax racket/base syntax/parse))

(provide (all-defined-out))


; allows defining aliases in the form:
; alias x = y
; or:
; alias x y

(define-line-macro alias
  (syntax-parser
    [(_ name:id (~datum =) value:expr ...) #'(define-simple-pipeline-alias name value ...)]
    [(_ name:id value:expr ...) #'(define-simple-pipeline-alias name value ...)]))

; similar except doesn't use define-simple-pipeline-alias
; so it doesn't use =unix-pipe=
; also syntax-parser-ception warning



; ls aliases
alias ls = (if (string=? (substring (getenv "TERM") 0 5)
              "xterm")
           'ls_extended
           'ls)
alias la = ls -a
alias ll = ls -la
alias l = ls -l


