#lang rash

(require rash/private/rashrc-git-stuff)

; 
(define (create-colored-string to-color 
                               #:fg [foreground 0]
                               #:bg [background 0])
  (define (create-color-command fg-or-bg)))


(define (powerline-prompt #:last-return-value [last-ret #f]
                          #:last-return-index [last-ret-n 0])
  (define path-to-print (if (getenv "HOME")
                            (regexp-replace (string-append "^" (regexp-quote (getenv "HOME")))
                                            (path->string (current-directory))
                                            "~")
                            (path->string (current-directory))))
  (define git-stuff (get-git-info))
  (define git-stuff-to-print (if git-stuff
                                 (hash-ref git-stuff 'branch)
                                 #f))
  (displayln (format "\033[48;5;31;38;5;231m ~a \033[0m\033[38;2;0;135;175m\uE0B0" path-to-print))
  (displayln "\033[36m\uE0A1")
  (displayln "\033[36m\uE0A2")
  (displayln "\033[36m\uE0A3")
  (displayln "\033[36m\uE0B0")
  (displayln "\033[36m\uE0B1")
  (displayln "\033[36m\uE0B2")
  (displayln "\033[36m\uE0B3")
  (displayln "\033[36m\uE0B8")
  (displayln "\033[36m\uE0B9")
  (displayln "\033[36m\uE0BA")
  (displayln "\033[36m\uE0BB")
  (displayln "\033[36m\uE0BC")
  (displayln "\033[36m\uE0BD")
  (displayln "\033[36m\uE0BE")
  (displayln "\033[36m\uE0BF"))

(powerline-prompt)
