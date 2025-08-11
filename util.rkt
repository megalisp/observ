#lang racket/base

(require json
		 "logs.rkt")

(provide last-obs-response-box show-last-obs-response)

(provide set-and-log-last-obs-response)


;; Shared mutable box for last OBS response
(define last-obs-response-box (box #f))

;; Set the last response and log it
(define (set-and-log-last-obs-response resp)
	(set-box! last-obs-response-box resp)
	(when resp (log-obs-response resp)))

;; Helper to pretty-print the last response
(define (show-last-obs-response)
	(let ([resp (unbox last-obs-response-box)])
		(if resp
				(begin
					(write-json resp (current-output-port) #:indent 2)
					(newline))
				(printf "No OBS response received yet.\n"))))
