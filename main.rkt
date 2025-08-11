#!/usr/bin/env racket
#lang racket/base

(require "reqs.rkt"
         "conn.rkt"
         "repl.rkt")

;; Re-export all functions for REPL use
(provide (all-from-out "conn.rkt")
         (all-from-out "repl.rkt"))

(define-values (main-conn recv-thread)
  (obs-connect #:auto-record? #t #:auto-scene "Scene 2"))
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

