#lang racket/base



(require "reqs.rkt"
         "conn.rkt"
         "api.rkt"
         "util.rkt"
         xrepl)

(require "auto.rkt")

;; Re-export all OBS functions for REPL use
(provide (all-from-out "reqs.rkt")
         (all-from-out "conn.rkt")
         show-last-obs-response
         last-obs-response-box
         repl-loop)

;; REPL loop for interactive use - now uses xrepl
(define (repl-loop active-conn)
  ;; Set the current connection for convenience functions
  (current-conn active-conn)
  ;; Start the enhanced REPL
  (read-eval-print-loop))