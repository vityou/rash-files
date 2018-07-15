#lang rash

(require reprovide/reprovide ; requires and provides all defined out
         racket/require-syntax)

(provide (all-defined-out))


(reprovide "aliases.rkt" 
           "line-macros.rkt"
           (for-syntax racket/base syntax/parse)
           (only-in rash/demo/setup val))


(define-require-syntax (here stx)
  (syntax-parse stx
    [(_ path:str)
     (datum->syntax stx `(file ,(string-append (path->string (current-directory))
                                               (syntax->datum #'path))))]))

(define-syntax (req-here stx)
  (syntax-parse stx
    [(_ path:str)
     (datum->syntax stx `(require
                          (file ,(string-append
                                  (path->string (current-directory))
                                  (syntax->datum #'path)))))]))
