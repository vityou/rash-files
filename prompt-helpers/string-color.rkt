#lang rash

(require rash/private/rashrc-git-stuff
         racket/list)


; hash for 4 bit colors
; (color-name . '(foreground-color-code background-color-code))
(define color-hash
  #hash(("black" . (30 40))
        ("red" . (31 41))
        ("green" . (32 42))
        ("yellow" . (33 43))
        ("blue" . (34 44))
        ("magenta" . (35 45))
        ("cyan" . (36 46))
        ("white" . (37 47))
        ("bright black" . (90 100))
        ("bright red" . (91 101))
        ("bright green" . (92 102))
        ("bright yellow" . (93 103))
        ("bright blue" . (94 104))
        ("bright magenta" . (95 105))
        ("bright cyan" . (96 106))
        ("bright white" . (97 107))))


; if you type in a string, it will treat it as a name for a 4 bit
; color number that it will get from `color-hash`
; if you type in a number it will treat it at an 8bit/256color number
; if you type in a list, it will treat it as a 24 bit/rgb color
; #f means no color and is default
; #:fg "green" -> treated as 4 bit
; #:fg 41 -> treated as 8 bit springgreen3 color
; #:fg '(r g b) -> treated as a 24 bit color
(define (create-colored-string to-color
                               #:fg [foreground #f]
                               #:bg [background #f]
                               #:bold? [bold? #f]
                               #:italic? [italic? #f]
                               #:underlined? [underlined? #f]
                               #:reset-before? [reset-before? #t] ; reset all attributes before setting your own
                               #:other-commands [other-commands ""]) ; string with normal ansi escape commands
  (define foreground-command
    (if foreground
        (cond
          [(string? foreground) (format "\033[~am" (first (hash-ref color-hash foreground)))]
          [(number? foreground) (format "\033[38;5;~am" foreground)]
          [(list? foreground) (format "\033[38;2;~a;~a;~am"
                                      (first foreground)
                                      (second foreground)
                                      (third foreground))])
        ""))
  (define background-command
    (if background
        (cond
          [(string? background) (format "\033[~am" (second (hash-ref color-hash background)))]
          [(number? background) (format "\033[48;5;~am" background)]
          [(list? background) (format "\033[48;2;~a;~a;~am"
                                      (first background)
                                      (second background)
                                      (third background))])
        ""))
  (define-values (bold-str ital-str und-str resetbf-str)
    (values (if bold? "\033[1m" "")
            (if italic? "\033[3m" "")
            (if underlined? "\033[4m" "")
            (if reset-before? "\033[0m" "")))

  (string-append resetbf-str
                 foreground-command
                 background-command
                 bold-str
                 ital-str
                 und-str
                 other-commands
                 to-color
                 "\033[0m"))


(module+ main
  (displayln (create-colored-string "asdf123test hi there im a test string! bye!"
                                    #:fg '(1 161 82)
                                    #:bg 62
                                    #:bold? #t
                                    #:underlined? #t
                                    #:italic? #t)))

