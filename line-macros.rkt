#lang rash

(require (for-syntax racket/base
		     syntax/parse))

(provide (except-out (all-defined-out)
                     quit)
         (rename-out [quit exit]))


; stands for "simple line macro"
(define-line-macro slm
  (syntax-parser
    ; if lm is defined in the form `slm name = (blah x y)`
    [(_ name:id (~datum =) (~and value:expr (~not line-macro)))
     #'(define-line-macro name
         (syntax-parser
           [(_) #'value]))]
    ; if lm is defined with multiple things after `=` ex: `slm name = blah x y`
    ; it just wraps them in parentheses so it would become `(blah x y)`
    [(_ name:id (~datum =) first-thing ...)
     #'(define-line-macro name
         (syntax-parser
           [(_) #'(first-thing ...)]))]))


; set export environment variables
(define-line-macro export
  (syntax-parser
    [(_ i:id (~datum =) value) #'(putenv (symbol->string 'i) value)]
    [(_ i:id value) #'(putenv (symbol->string 'i) value)]))


; stands for "run racket"
; allows you to do things like `rr display "hi"` or `rr exit`
(define-line-macro rr
  (syntax-parser
    [(_ to-run ...) #'(to-run ...)]))


slm ~ = cd
slm .. = cd ..
slm ../.. = cd ../..

slm quit = (exit)
