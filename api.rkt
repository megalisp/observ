
#lang racket/base

(require "auto.rkt"
         "conn.rkt"
         racket/file
         racket/string
         (only-in "reqs.rkt" current-conn current-print-results))

(provide (all-defined-out)
         obs-api-registry
         obs-api-docs)

;; Registry to store function metadata for REPL dispatch
(define obs-api-registry (make-hash))

;; Registry to store function documentation and metadata
(define obs-api-docs (make-hash))

;; Helper function for keyword lookup
(define (find-keyword-value args keyword-symbol)
  (let loop ([remaining args])
    (cond
      [(null? remaining) #f]
      [(null? (cdr remaining)) #f]
      [(eq? (car remaining) keyword-symbol) (cadr remaining)]
      [else (loop (cdr remaining))])))

;; Symbol to string conversion helper
(define (symbol->str val) (if (symbol? val) (symbol->string val) val))

;; Define OBS API functions
(define-syntax-rule
  (define-obs-api (name . user-args) keyword-list doc-string req-func-call)
  (begin
    ;; Define public function that uses current-conn
    (define (name . user-args)
      (let ([result req-func-call])
        (when (and (current-print-results) (not (void? result)))
          (printf "~a\n\n" result))
        result))

    ;; Define dispatcher that pulls args from REPL-friendly form
    (define (name-dispatcher args conn)
      (define-values (actuals missing)
        (for/fold ([actuals '()] [missing '()])
                  ([kw (in-list keyword-list)])
          (define val (find-keyword-value args kw))
          (if val
              (values (append actuals (list kw (symbol->str val)))
                      missing)
              (values actuals (cons kw missing)))))
      (if (null? missing)
          (parameterize ([current-conn conn])
            (apply name actuals))
          (format "Error: missing required keyword(s): ~a" missing)))

    ;; Register in the API registry
    (hash-set! obs-api-registry 'name name-dispatcher)
    
    ;; Store documentation metadata
    (hash-set! obs-api-docs 'name 
               (hash 'docstring doc-string
                     'keywords keyword-list
                     'args 'user-args))))


;; Evaluate S-expression with connection parameter injected
(define (eval-with-connection expr conn)
  (parameterize ([current-conn conn])
    (cond
      [(and (list? expr) (not (null? expr)))
       (define func-name (car expr))
       (define args (cdr expr))
       (define dispatcher (hash-ref obs-api-registry func-name #f))
       (if dispatcher
           (dispatcher args conn)
           (format "Unknown API function: ~a" func-name))]
      [(symbol? expr)
       (define dispatcher (hash-ref obs-api-registry expr #f))
       (if dispatcher
           (dispatcher '() conn)
           (format "Unknown API function: ~a" expr))]
      [else (format "Invalid expression: ~a" expr)])))

;; ====================================
;; OBS WebSocket API - Idiomatic Wrappers
;; ====================================

(define-obs-api (obs!version) '()
  "Get OBS Studio and WebSocket plugin version information"
  (obs-get-version))

(define-obs-api (obs!stats) '()
  "Get OBS Studio statistics like CPU usage, memory, etc."
  (obs-get-stats))

;; ====================================
;; Scene Functions
;; ====================================

(define-obs-api (obs!scene-list) '()
  "Get list of all scenes"
  (obs-get-scene-list))

(define-obs-api (obs!scene-current) '()
  "Get current program scene"
  (obs-get-current-program-scene))


(define-obs-api (obs!scene-switch #:to scene-name #:uuid [scene-uuid #f]) '(#:to #:uuid)
  "Switch to a scene"
  (obs-set-current-program-scene scene-name scene-uuid))


;; obs-create-scene expects just sceneName
(define-obs-api (obs!scene-create #:name scene-name) '(#:name)
  "Create a new scene"
  (obs-create-scene scene-name))


(define-obs-api (obs!scene-remove #:name scene-name #:uuid [scene-uuid #f]) '(#:name #:uuid)
  "Remove a scene"
  (obs-remove-scene scene-name scene-uuid))


(define-obs-api (obs!scene-rename #:from old-name #:to new-name #:uuid [scene-uuid #f]) '(#:from #:to #:uuid)
  "Rename a scene"
  (obs-set-scene-name old-name scene-uuid new-name))

;; ====================================
;; Input/Source Functions
;; ====================================

(define-obs-api (obs!input-list) '()
  "Get list of inputs"
  (obs-get-input-list))

(define-obs-api (obs!input-kinds) '()
  "Get list of available input kinds/types"
  (obs-get-input-kind-list))


(define-obs-api (obs!input-create #:scene scene-name #:name input-name #:kind input-kind #:settings [settings (hasheq)] #:scene-uuid [scene-uuid #f] #:enabled [scene-item-enabled #t])
  '(#:scene #:name #:kind #:settings #:scene-uuid #:enabled)
  "Create a new input in a scene with optional settings"
  (obs-create-input scene-name scene-uuid input-name input-kind settings scene-item-enabled))


(define-obs-api (obs!input-remove #:input input-name #:uuid [input-uuid #f]) '(#:input #:uuid)
  "Remove an input"
  (obs-remove-input input-name input-uuid))


(define-obs-api (obs!input-rename #:from old-name #:to new-name #:uuid [input-uuid #f]) '(#:from #:to #:uuid)
  "Rename an input"
  (obs-set-input-name old-name input-uuid new-name))


(define-obs-api (obs!input-set-settings #:input input-name #:settings settings #:uuid [input-uuid #f] #:overlay [overlay #f]) '(#:input #:settings #:uuid #:overlay)
  "Set input settings"
  (obs-set-input-settings input-name input-uuid settings overlay))

;; ====================================
;; Transform Functions
;; ====================================



;; ====================================
;; Audio Functions
;; ====================================


(define-obs-api (obs!audio-mute #:input input-name #:uuid [input-uuid #f]) '(#:input #:uuid)
  "Mute an input"
  (obs-set-input-mute input-name input-uuid #t))


(define-obs-api (obs!audio-unmute #:input input-name #:uuid [input-uuid #f]) '(#:input #:uuid)
  "Unmute an input"
  (obs-set-input-mute input-name input-uuid #f))


(define-obs-api (obs!audio-toggle #:input input-name #:uuid [input-uuid #f]) '(#:input #:uuid)
  "Toggle input mute status"
  (obs-toggle-input-mute input-name input-uuid))


(define-obs-api (obs!audio-set-volume #:input input-name #:level level #:uuid [input-uuid #f]) '(#:input #:level #:uuid)
  "Set input volume (0.0 to 1.0 multiplier)"
  (obs-set-input-volume input-name input-uuid level #f))


(define-obs-api (obs!audio-set-volume-db #:input input-name #:db db-level #:uuid [input-uuid #f]) '(#:input #:db #:uuid)
  "Set input volume in decibels"
  (obs-set-input-volume input-name input-uuid #f db-level))


(define-obs-api (obs!audio-get-volume #:input input-name #:uuid [input-uuid #f]) '(#:input #:uuid)
  "Get input volume"
  (obs-get-input-volume input-name input-uuid))

;; ====================================
;; Advanced Audio Functions
;; ====================================

(define-obs-api (obs!audio-monitor-set #:input input-name #:mode mode #:uuid [input-uuid #f]) '(#:input #:mode #:uuid)
  "Set the audio monitoring mode for a source: 'off', 'only', or '&output'"
  (let* ([mode-str (cond
                  [(equal? mode "off") "OBS_MONITORING_TYPE_NONE"]
                  [(equal? mode "only") "OBS_MONITORING_TYPE_MONITOR_ONLY"]
                  [(or (equal? mode "&output") (equal? mode "andoutput") (equal? mode "monitorAndOutput")) "OBS_MONITORING_TYPE_MONITOR_AND_OUTPUT"]
                  [else mode])])
    (obs-set-input-audio-monitor-type input-name input-uuid mode-str)))

;; [ADD] obs!audio-tracks-set
;; ... ... ...

;; ====================================
;; Media Playback Functions
;; ====================================

(define-obs-api (obs!media-input-status #:input input-name) '(#:input)
  "Get the status of a media input (state, duration, cursor)"
  (obs-get-media-input-status input-name))

(define-obs-api (obs!input-trigger-media-action #:input input-name #:action action) '(#:input #:action)
  "Trigger a media action (play, pause, restart, etc.) on a media input"
  (obs-trigger-media-input-action input-name action))

(define-obs-api (obs!media-play #:input input-name #:uuid [input-uuid #f]) '(#:input #:uuid)
  "Explicitly play a media input (same as trigger-media-action 'play')"
  (obs-trigger-media-input-action input-name input-uuid "play"))

(define-obs-api (obs!media-pause #:input input-name #:uuid [input-uuid #f]) '(#:input #:uuid)
  "Explicitly pause a media input (same as trigger-media-action 'pause')"
  (obs-trigger-media-input-action input-name input-uuid "pause"))

(define-obs-api (obs!media-restart #:input input-name #:uuid [input-uuid #f]) '(#:input #:uuid)
  "Explicitly restart a media input (same as trigger-media-action 'restart')"
  (obs-trigger-media-input-action input-name input-uuid "restart"))

(define-obs-api (obs!media-input-set-cursor #:input input-name #:cursor media-cursor) '(#:input #:cursor)
  "Set the cursor position of a media input (in ms)"
  (obs-set-media-input-cursor input-name media-cursor))

(define-obs-api (obs!media-input-offset-cursor #:input input-name #:offset media-cursor-offset) '(#:input #:offset)
  "Offset the current cursor position of a media input by the specified value (in ms)"
  (obs-offset-media-input-cursor input-name media-cursor-offset))


;; ====================================
;; Recording Functions
;; ====================================

(define-obs-api (obs!record-status) '()
  "Get current recording status"
  (obs-get-record-status))

(define-obs-api (obs!record-start) '()
  "Start recording"
  (obs-start-record))

(define-obs-api (obs!record-stop) '()
  "Stop recording"
  (obs-stop-record))

(define-obs-api (obs!record-toggle) '()
  "Toggle recording on/off"
  (obs-toggle-record))

;; ====================================
;; Streaming Functions
;; ====================================

(define-obs-api (obs!stream-status) '()
  "Get current streaming status"
  (obs-get-stream-status))

(define-obs-api (obs!stream-start) '()
  "Start streaming"
  (obs-start-stream))

(define-obs-api (obs!stream-stop) '()
  "Stop streaming"
  (obs-stop-stream))

(define-obs-api (obs!stream-toggle) '()
  "Toggle streaming on/off"
  (obs-toggle-stream))

;; ====================================
;; Virtual Camera Functions
;; ====================================

(define-obs-api (obs!virtualcam-status) '()
  "Get virtual camera status"
  (obs-get-virtual-cam-status))

(define-obs-api (obs!virtualcam-start) '()
  "Start virtual camera"
  (obs-start-virtual-cam))

(define-obs-api (obs!virtualcam-stop) '()
  "Stop virtual camera"
  (obs-stop-virtual-cam))

(define-obs-api (obs!virtualcam-toggle) '()
  "Toggle virtual camera on/off"
  (obs-toggle-virtual-cam))

;; ====================================
;; Utility Functions
;; ====================================

(define-obs-api (obs!profile-list) '()
  "Get list of all profiles"
  (obs-get-profile-list))

(define-obs-api (obs!collection-list) '()
  "Get list of all scene collections"
  (obs-get-scene-collection-list))

(define-obs-api (obs!studio-mode) '()
  "Get studio mode status"
  (obs-get-studio-mode-enabled))

(define-obs-api (obs!studio-mode-enable) '()
  "Enable studio mode"
  (obs-set-studio-mode-enabled #t))

(define-obs-api (obs!studio-mode-disable) '()
  "Disable studio mode"
  (obs-set-studio-mode-enabled #f))

(define-obs-api (obs!studio-mode-transition) '()
  "Trigger a studio mode transition from preview to program"
  (obs-trigger-studio-mode-transition))

(define-obs-api (obs!monitor-list) '()
  "Get list of available monitors"
  (obs-get-monitor-list))

(define-obs-api (obs!source-screenshot #:name source-name) '(#:name)
  "Take a screenshot of a source and return base64 data"
  (obs-get-source-screenshot source-name))

(define-obs-api (obs!source-screenshot-save #:name source-name #:file file-path) '(#:name #:file)
  "Save a screenshot of a source to file"
  (obs-save-source-screenshot source-name file-path))


;; ====================================
;; REPL Utility Functions
;; ====================================

(define-obs-api (obs!sleep #:secs seconds) '(#:secs)
  "Sleep for a specified number of seconds (can be fractional)"
  (begin
    (sleep seconds)
    (format "Slept for ~a seconds" seconds)))

(define-obs-api (obs!load #:file file-path) '(#:file)
  "Load and execute a Racket file in the REPL context"
  (if (file-exists? file-path)
      (with-handlers ([exn:fail? (lambda (e) 
                                   (format "Error loading file ~a: ~a" file-path (exn-message e)))])
        (define file-content (file->string file-path))
        (define input-port (open-input-string file-content))
        (define results '())
        (let loop ()
          (define expr (read input-port))
          (unless (eof-object? expr)
            ;; Use regular eval instead of eval-with-connection for Racket code
            (define result (parameterize ([current-conn (current-conn)])
                             (eval expr)))
            (set! results (cons result results))
            (loop)))
        (close-input-port input-port)
        (format "Loaded ~a with ~a expressions" file-path (length results)))
      (format "File not found: ~a" file-path)))

(define-obs-api (obs!desc func-name) '()
  "Describe an OBS API function, showing its docstring and required keywords"
  (let ([func-symbol (cond
                       [(symbol? func-name) func-name]
                       [(string? func-name) (string->symbol func-name)]
                       [else #f])])
    (if func-symbol
        (let ([doc-info (hash-ref obs-api-docs func-symbol #f)])
          (if doc-info
              (let ([docstring (hash-ref doc-info 'docstring)]
                    [keywords (hash-ref doc-info 'keywords)]
                    [args (hash-ref doc-info 'args)])
                (begin
                  (newline)
                  (printf "Function: ~a~n" func-symbol)
                  (printf "Description: ~a~n" docstring)
                  (if (null? keywords)
                      (printf "Parameters: (none)~n")
                      (printf "Parameters: ~a~n" 
                              (string-join (map (lambda (kw) (format "~a" kw)) keywords) " ")))
                  (printf "Example usage: (~a~a)~n" 
                          func-symbol
                          (if (null? keywords)
                              ""
                              (string-append " " (string-join 
                                                 (map (lambda (kw) (format "~a <value>" kw)) keywords) 
                                                 " "))))
                  (newline)
                  (void)))
              (begin
                (printf "Unknown function: ~a~n" func-symbol)
                (printf "Available functions: ~a~n" 
                        (string-join (map symbol->string (sort (hash-keys obs-api-docs) symbol<?)) " "))
                (void))))
        (begin
          (printf "Usage: (obs!desc 'function-name)~n")
          (printf "Available functions: ~a~n" 
                  (string-join (map symbol->string (sort (hash-keys obs-api-docs) symbol<?)) " "))
          (void)))))

(define-obs-api (obs!list) '()
  "List all available OBS API functions"
  (begin
    (printf "Available OBS API functions:~n")
    (for-each (lambda (func-name)
                (let ([doc-info (hash-ref obs-api-docs func-name)])
                  (printf "  ~a - ~a~n" func-name (hash-ref doc-info 'docstring))))
              (sort (hash-keys obs-api-docs) symbol<?))
    (void)))