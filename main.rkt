#!/usr/bin/env racket
#lang racket/base

(require "reqs.rkt"
         "conn.rkt"
         "repl.rkt")

;; Re-export all functions for REPL use
(provide (all-from-out "conn.rkt")
         (all-from-out "repl.rkt"))


;; current-command-line-arguments returns a vector, convert to list for easier processing
(define (parse-args args)
  (let loop ([args (vector->list args)] [ip #f])
    (cond
      [(null? args) ip]
      [(and (equal? (car args) "--ip") (pair? (cdr args)))
       (loop (cddr args) (cadr args))]
      [else (loop (cdr args) ip)])))

(define ip-arg (parse-args (current-command-line-arguments)))

(define main-conn #f)
(define recv-thread #f)
(with-handlers ([exn:fail?
                 (lambda (e)
                   (printf "Could not connect to OBS: ~a\n" (exn-message e))
                   (printf "\nNOTE: If you are connecting to OBS running locally, make \n sure OBS is running & its WebSocket server is enabled.\n")
                   (printf "\nYou can also use (obs-connect #:ip \"<ip>\") in the REPL \n to remote in to different computer and try again.\n")
                   (set! main-conn #f)
                   (set! recv-thread #f))])
  (define-values (conn thread)
    (if ip-arg
        (obs-connect #:ip ip-arg #:auto-record? #t #:auto-scene "Scene 2")
        (obs-connect #:auto-record? #t #:auto-scene "Scene 2")))
  (set! main-conn conn)
  (set! recv-thread thread))
(when main-conn
  (printf "Connection established!\n"))
(printf "\n")
(printf "╔════════════════════════════════════════════════════╗\n")
(printf "║  ██████  ██████  ███████ ███████ ██████  ██    ██  ║\n")
(printf "║ ██    ██ ██   ██ ██      ██      ██   ██ ██    ██  ║\n")
(printf "║ ██    ██ ██████  ███████ █████   ██████  ██    ██  ║\n")
(printf "║ ██    ██ ██   ██      ██ ██      ██   ██  ██  ██   ║\n")
(printf "║  ██████  ██████  ███████ ███████ ██   ██   ████    ║\n")
(printf "║                                                    ║\n")
(printf "║        !!! PRE-RELEASE !!! - USE AT YOUR OWN RISK! ║\n")
(printf "╚════════════════════════════════════════════════════╝\n")
(printf "\n")
(printf "Submit ',enter repl.rkt' (for the magic to happen) and then\n")
(printf "tab-complete after typing `(obs!` to see available cmds.\n")
(printf "\n")
(printf "Type ',quit' or press Ctrl+C to exit.\n")

(repl-loop main-conn)

