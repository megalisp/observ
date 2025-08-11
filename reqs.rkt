#lang racket/base

(require json
         racket/format
         net/rfc6455)

(require racket/string)


(provide (all-defined-out) current-print-results)

;; Request counter and ID generation
(define request-counter (make-parameter 0))

;; Current connection parameter - defined here since send-request! needs it
(define current-conn (make-parameter #f))
(define current-print-results (make-parameter #f))

(define (next-request-id)
  (define id (~a "r" (request-counter)))
  (request-counter (add1 (request-counter)))
  id)

;; Core request sending function - gets current-conn from environment
(define (send-request! op-type d)
  ;; This will be set by api.rkt when it loads
  (define conn (current-conn))
  (unless conn (error "No connection established. Use (current-conn connection) first."))
  (define id (next-request-id))
  (define d-with-id
    (hasheq 'requestType (cdr (assoc "requestType" d))
            'requestId id
            'requestData (cdr (assoc "requestData" d))))
  (define msg
    (hasheq 'op op-type
            'd d-with-id))
  (ws-send! conn (jsexpr->string msg))
  id)


;; --- OBS Request Function Generator ---
;; Load the full OBS protocol JSON and extract the requests array
(define obs-requests
  (let* ([proto (call-with-input-file "misc/obs-websocket-protocol.json" read-json)]
         [requests (hash-ref proto 'requests)])
    requests))

;; Debug: print the request type being processed

(define (make-req-fn req)
  (define req-type (hash-ref req 'requestType))
  (displayln (string-append "Generating function for: " (format "~a" req-type)))
  (define fields (hash-ref req 'requestFields '()))
  ;; Improved CamelCase to kebab-case: GetVersion -> obs-get-version
  (define fn-name
    (string->symbol
      (string-append "obs-"
        (string-downcase
          (regexp-replace* #px"([a-z])([A-Z])" req-type "\\1-\\2")))))
  (define arg-names (for/list ([f fields]) (string->symbol (hash-ref f 'valueName))))
  (define reqdata-expr
    (if (null? fields)
        "(hasheq)"
        (string-append "(hasheq "
          (string-join (for/list ([f fields])
            (format "'~a ~a" (hash-ref f 'valueName) (string->symbol (hash-ref f 'valueName)))) " ")
          ")")))
  (define fn-str
    (if (null? arg-names)
      (format "(define (~a)\n  (send-request! 6 `((\"requestType\" . \"~a\")\n                     (\"requestData\" . ,~a))))\n"
        fn-name req-type reqdata-expr)
      (format "(define (~a ~a)\n  (send-request! 6 `((\"requestType\" . \"~a\")\n                     (\"requestData\" . ,~a))))\n"
        fn-name
        (string-join (map symbol->string arg-names) " ")
        req-type
        reqdata-expr)))
  fn-str)

;; Generate all request functions
(define req-fns
  (string-join (for/list ([req obs-requests])
    (make-req-fn req)) "\n"))

;; Debug: print the generated function definitions
(printf "\nGenerated function definitions:\n~a\n" req-fns)

;; Write the generated functions to auto.rkt
(define auto-header
  "#lang racket/base\n\n;; ----------------------------------------------------------------------\n;; THIS FILE IS AUTO-GENERATED. DO NOT EDIT MANUALLY.\n;; Any manual changes will be lost.\n;; ----------------------------------------------------------------------\n\n(require \"reqs.rkt\")\n\n(provide (all-defined-out))\n\n")

(call-with-output-file "auto.rkt"
  (lambda (out)
    (display auto-header out)
    (display req-fns out))
  #:exists 'replace)
