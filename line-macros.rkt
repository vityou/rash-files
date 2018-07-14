#lang rash

(require (for-syntax racket/base
                     syntax/parse
                     linea/line-macro-prop))

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


; cd macros
slm ~ = cd
slm .. = cd ..
slm ../.. = cd ../..


slm exit-repl = (begin (if (file-exists? "/mnt/c/Users/zlee3/.racket/.LOCKracket-prefs.rktd")
                           (delete-file "/mnt/c/Users/zlee3/.racket/.LOCKracket-prefs.rktd")
                           0) 
                       (exit))

