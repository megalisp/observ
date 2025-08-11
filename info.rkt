#lang info

;; ============================================================================
;; Observ - Racket OBS WebSocket Server Controller
;; ============================================================================

(define collection "observ")
(define pkg-desc "Programatically Control OBS-Studio's WebSocket Server.")
(define version "0.0.1")
(define pkg-authors '("megalisp"))

(define license '(Apache-2.0 OR MIT))

(define deps 
  '("base"
    "net-lib"
    "json-lib"  
    "web-server-lib"
    "rackunit-lib"
    "scribble-lib"
    "racket-doc"))

(define build-deps 
  '("scribble-lib" 
    "racket-doc"))

(define scribblings '(("manual.scrbl" ())))

(define categories '(net api automation))
(define tags '("obs" "streaming" "websocket" "automation" "video" "broadcast"))

(define source-url "https://github.com/megalisp/observ")
(define bug-reports "https://github.com/megalisp/observ/issues")
(define documentation-url "https://docs.racket-lang.org/observ/")

(define racket-launcher-names '("observ"))
(define racket-launcher-libraries '("main.rkt"))

(define test-omit-paths '("examples/"))

(define implies '())
(define setup-collects '())

(define platforms '(unix macosx windows))

(define minimum-racket-version "8.0")

(define blurb 
  '("Observ is a Racket library x repl interface for controlling OBS Studio through "
    "its WebSocket API x Server. The whole websocket server protocol is callable"
    "and programatically generated. And we have an api and nicities on-top of that."))
