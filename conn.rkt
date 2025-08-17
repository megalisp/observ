#lang racket/base

(require net/url
         json
         racket/format
         racket/port
         net/rfc6455
         net/base64
         file/sha1
         "reqs.rkt"
         "auto.rkt")



(require "util.rkt")

(provide obs-connect
         obs-disconnect
         pretty-print-json
         obs-password
         DEFAULT-OBS-WS-URL
         current-connection
         current-recv-thread)



(define DEFAULT-OBS-WS-URL "ws://localhost:4455")
(define obs-password (getenv "OBS_WEBSOCKET_SERVER_PASSWORD"))

;; Connection state management
(define current-connection #f)
(define current-recv-thread #f)

(define (generate-auth-response password salt challenge)
  (define secret (sha1-bytes 
                  (open-input-bytes 
                   (bytes-append (string->bytes/utf-8 password) 
                                (base64-decode (string->bytes/utf-8 salt))))))
  (define auth (sha1-bytes 
                (open-input-bytes 
                 (bytes-append secret 
                              (base64-decode (string->bytes/utf-8 challenge))))))
  (bytes->string/utf-8 (base64-encode auth)))

(define (pretty-print-json j)
  (write-json j (current-output-port) #:indent 2))

(define (create-recv-loop conn #:auto-record? [auto-record? #f] #:auto-scene [auto-scene #f])
  (lambda ()
    (define msg (ws-recv conn #:payload-type 'text))
    (unless (eof-object? msg)
  (define parsed (string->jsexpr msg))
      (newline)
      (printf "<<< Incoming JSON from OBS:\n")
      (pretty-print-json parsed)
      (newline)
      
      ;; Handle different op codes
      (define op (hash-ref parsed 'op #f))
      (define d (hash-ref parsed 'd #f))
      
      (printf "DEBUG: Received op code: ~a\n" op)
      
      (cond
        [(= op 0) ; Hello message
         (printf "Received Hello message, sending Identify...\n")
         (if (and obs-password d (hash-ref d 'authentication #f))
             ;; Authentication required
             (let* ([auth-info (hash-ref d 'authentication)]
                    [challenge (hash-ref auth-info 'challenge)]
                    [salt (hash-ref auth-info 'salt)]
                    [auth-response (generate-auth-response obs-password salt challenge)])
               (printf "DEBUG: Generated auth response: ~a\n" auth-response)
               (define identify-msg
                 (hasheq 'op 1
                         'd (hasheq 'rpcVersion 1
                                   'authentication auth-response)))
               (ws-send! conn (jsexpr->string identify-msg)))
             ;; No authentication required
             (let ([identify-msg (hasheq 'op 1
                                        'd (hasheq 'rpcVersion 1))])
               (printf "DEBUG: No authentication required\n")
               (ws-send! conn (jsexpr->string identify-msg))))]
        
        [(= op 2) ; Identified message  
         (printf "Successfully identified! Ready to send requests.\n")
         ;; Set the current connection for the API functions
         (current-conn conn)
         (when auto-record?
           (printf "Starting recording automatically...\n")
           (obs-start-record))
         (when auto-scene
           (printf "Switching to ~a...\n" auto-scene)
           (obs-set-current-program-scene auto-scene #f))]
        
        [(= op 4) ; Close message
         (printf "Connection close requested by OBS.\n")]
        
        [(= op 7) ; RequestResponse message
         (printf "Received request response!\n")
         (set-and-log-last-obs-response (hash-ref (hash-ref parsed 'd #hasheq()) 'responseData #f))
         (when d
           (define request-type (hash-ref d 'requestType #f))
           (define request-status (hash-ref d 'requestStatus #f))
           (printf "  Request: ~a\n" request-type)
           (printf "  Status: ~a\n" (hash-ref request-status 'result #f))
           (when (hash-ref request-status 'result #f)
             (define response-data (hash-ref d 'responseData #f))
             (when response-data
               (printf "  Response Data:\n")
               (pretty-print-json response-data)
               (newline))))]
        
        [else
         (printf "Unknown op code: ~a\n" op)])
      
      ((create-recv-loop conn #:auto-record? auto-record? #:auto-scene auto-scene)))))

(define (obs-connect #:ip [ip #f] #:auto-record? [auto-record? #f] #:auto-scene [auto-scene #f])
  (if current-connection
      (printf "Already connected to OBS! Use (obs-disconnect) first if you want to reconnect.\n")
      (let*
          ([url (if ip
                    (regexp-replace #rx"localhost" DEFAULT-OBS-WS-URL ip)
                    DEFAULT-OBS-WS-URL)]
           [_ (printf "Attempting to connect to ~a...\n" url)]
           [_ (printf "Password set: ~a\n" (if obs-password "Yes" "No"))]
           [conn (ws-connect (string->url url))]
           [_ (printf "Connected successfully!\n")]
           [recv-thread (thread (create-recv-loop conn #:auto-record? auto-record? #:auto-scene auto-scene))]
           [_ (printf "Connecting to OBS WebSocket...\n")]
           [_ (sleep 2)])
        ;; Set connection state
        (set! current-connection conn)
        (set! current-recv-thread recv-thread)
        ;; Set up the convenience wrappers with current connection
        (current-conn conn)
        (current-print-results #t)
        ;; Display connection established message
        (values conn recv-thread))))

(define obs-disconnect 
  (case-lambda
    ;; No parameters - use current connection state
    [()
     (cond
       [current-connection
        (obs-disconnect current-connection current-recv-thread)
        (set! current-connection #f)
        (set! current-recv-thread #f)]
       [else
        (printf "Not connected to OBS! Use (obs-connect) to establish a connection first.\n")])]
    ;; Two parameters - legacy interface for direct connection/thread management
    [(conn recv-thread)
     (when conn
       (ws-close! conn)
       (when recv-thread
         (kill-thread recv-thread))
       (printf "Disconnected from OBS WebSocket.\n"))]))
