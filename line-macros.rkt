#lang rash

(require (for-syntax racket/base
                     syntax/parse
                     linea/line-macro-prop)
         (rename-in k-infix [$ k-infix-macro])
         syntax/parse)

(provide (except-out (all-defined-out)
                     exit-repl)
         (rename-out [exit-repl exit]))


; stands for "simple line macro"
(define-line-macro slm
  (syntax-parser
    ; if lm is defined in the form `slm name = (blah x y)`
    [(_ name:id (~optional (~datum =)) (~and value:expr (~not x:line-macro)))
     #'(define-line-macro name
         (syntax-parser
           [(_) #'value]))]
    ; if lm is defined with multiple things after `=` ex: `slm name = blah x y`
    ; it just wraps them in parentheses so it would become `(blah x y)`
    [(_ name:id (~optional (~datum =)) first-thing ...)
     #'(define-line-macro name
         (syntax-parser
           [(_) #'(first-thing ...)]))]))


; set environment variables
(define-line-macro export
  (syntax-parser
    [(_ i:id (~optional (~datum =)) value) #'(putenv (symbol->string 'i) value)]))


; stands for "run racket"
; allows you to do things like `rr display "hi"` or `rr exit`
(define-line-macro rr
  (syntax-parser
    [(_ to-run ...) #'(to-run ...)]))


; allows for infix math like `1 + 1` and `sqrt 5 + 2`
; look at k-infix documentation for info
; I'm planning on making a more generalized version of this but k-infix is pretty good
(define-line-macro math
  (syntax-parser
    [(_ first ...) #'(k-infix-macro first ...)]))


; cd macros
slm ~ = cd
slm .. = cd ..
slm ../.. = cd ../..


; this file prevents the repl from closing
slm exit-repl = (begin (when (file-exists? (string-append (getenv "HOME") ".racket/.LOCKracket-prefs.rktd"))
                             (delete-file (string-append (getenv "HOME") ".racket/.LOCKracket-prefs.rktd")))
                       (exit))

