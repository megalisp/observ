#!/usr/bin/env racket
#lang racket/base

(require net/url
         racket/file
         racket/system
         racket/path
         racket/port)

;; ----------------------------------------------------------------------
;; OBS WebSocket Protocol Code Generator
;; ----------------------------------------------------------------------
;;
;; This script automates the generation of all OBS WebSocket command bindings for this project.
;;
;; How it works:
;; - All command functions are generated from the official OBS WebSocket protocol definition JSON.
;; - The protocol file is expected at seed/obs-websocket-protocol.json (or will be downloaded automatically
;;   from: https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.json)
;; - If the protocol file is missing, it will be downloaded to the seed/ directory.
;; - If an auto.rkt already exists, it will be renamed to auto.rkt-old as a backup.
;; - The script then runs reqs.rkt to generate a new auto.rkt based on the protocol JSON.
;;
;; Usage:
;; 1. Make this script executable: chmod +x gens.rkt
;; 2. Run it as a script: ./gens.rkt
;;    (No need to invoke racket explicitly.)

;; This ensures your OBS command bindings are always up-to-date with the latest protocol.

(define protocol-url "https://raw.githubusercontent.com/obsproject/obs-websocket/master/docs/generated/protocol.json")
(define protocol-path (build-path "seed" "obs-websocket-protocol.json"))
(define auto-path (build-path "auto.rkt"))
(define auto-old-path (build-path "auto.rkt-old"))

;; Download protocol.json if not present
(define (ensure-protocol-json)
  (unless (file-exists? protocol-path)
    (printf "Downloading protocol.json from ~a...\n" protocol-url)
    (make-directory* "seed")
    (call/input-url (string->url protocol-url)
                    get-pure-port
                    (lambda (in)
                      (call-with-output-file protocol-path
                        (lambda (out)
                          (copy-port in out))
                        #:exists 'replace)))
    (printf "Downloaded to ~a\n" protocol-path)))

;; Rename auto.rkt to auto.rkt-old if present
(define (maybe-rename-auto)
  (when (file-exists? auto-path)
    (printf "Renaming auto.rkt to auto.rkt-old...\n")
    (when (file-exists? auto-old-path)
      (delete-file auto-old-path))
    (rename-file-or-directory auto-path auto-old-path #t)
    (printf "Renamed.\n")))


;; Main entry point
(module+ main
  (ensure-protocol-json)
  (maybe-rename-auto)
  (printf "Generating new auto.rkt with reqs.rkt...\n")
  (define result (system* (find-executable-path "racket") "reqs.rkt"))
  (if (or (eq? result 0) (eq? result #t))
      (printf "auto.rkt generated successfully.\n")
      (printf "Error: reqs.rkt did not complete successfully (exit ~a)\n" result)))

(provide ensure-protocol-json maybe-rename-auto)
