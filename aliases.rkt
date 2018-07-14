#lang rash

(require (for-syntax racket/base syntax/parse)
         (only-in racket/string string-contains?))

(provide (except-out (all-defined-out) best-ls-command))


; allows defining aliases in the form:
; alias x = y
; or:
; alias x y
(define-line-macro alias
  (syntax-parser
    [(_ name:id (~optional (~datum =)) value:expr ...) #'(define-simple-pipeline-alias name value ...)]))


; determine the user's best ls command variant
; depending on the ones available
; and the TERM environment variable
(define (best-ls-command)
  (define term-var (getenv "TERM"))
  (if (and term-var
           (string-contains? term-var "xterm"))
      (cond
        [(find-executable-path "ls_extended") 'ls_extended]
        [(find-executable-path "exa") 'exa]
        [else '(ls --color=auto)])
      '(ls --color=auto)))


; ls aliases
alias ls = (best-ls-command)
alias la = ls -a
alias ll = ls -la
alias l = ls -l

; git aliases copied from rash/demo/setup
alias gc = "git" 'commit
alias gs = "git" 'status
alias gd = "git" 'diff
alias greb = "git" 'rebase
alias gru = "git" 'remote 'update
alias gunadd = "git" 'reset 'HEAD
alias gco = "git" 'checkout
alias gcob = "git" 'checkout '-b
alias gclone = "git" 'clone '--recursive
alias gp = "git" 'push
alias ga = "git" 'add
