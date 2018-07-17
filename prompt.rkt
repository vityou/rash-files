#lang rash

(define (powerline-prompt #:last-return-value [last-ret #f]
                          #:last-return-index [last-ret-n 0])

  (displayln (format "\033[48;5;31;38;5;231m ~a \033[0m\033[38;2;0;135;175m\uE0B0" (path->string (current-directory))))
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
