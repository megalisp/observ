#lang racket/base

(require json)

;; I eventually want extensive logging, but for now 
;; simplest solution that works "well enough" imo.

(provide log-obs-response)

;; Appends a response to the logs.repl-responses file
(define (log-obs-response resp)
  (call-with-output-file "logs.repl-responses"
    (lambda (out)
      (write-json resp out #:indent 2)
      (newline out)
      (for ([i (in-range 5)]) (newline out)))
    #:exists 'append))
