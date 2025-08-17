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

(define-values (main-conn recv-thread)
  (if ip-arg
      (obs-connect #:ip ip-arg #:auto-record? #t #:auto-scene "Scene 2")
      (obs-connect #:auto-record? #t #:auto-scene "Scene 2")))
(printf "Connection established!\n")
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
(printf "Submit ',enter repl.rkt' (if running locally) and then\n")
(printf "tab-complete after typing `(obs!` to see available cmds.\n")
(printf "\n")
(printf "Type ',quit' or press Ctrl+C to exit.\n")

(repl-loop main-conn)

