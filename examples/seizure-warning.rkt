;; scene-transition-demo.rkt - Clean macro-based scene transition demo
;; Load this file with: (obs!load #:file "examples/scene-transition-demo.rkt")

(require racket/string)

;; Helper function to convert hex to proper OBS color format
(define (hex-to-obs-color hex-string)
  (define clean-hex (substring hex-string 1)) ; remove #
  (define rgb (string->number clean-hex 16))
  (define r (bitwise-and (arithmetic-shift rgb -16) #xFF))
  (define g (bitwise-and (arithmetic-shift rgb -8) #xFF))
  (define b (bitwise-and rgb #xFF))
  ;; OBS uses ABGR format: Alpha-Blue-Green-Red (opposite of ARGB)
  (bitwise-ior #xFF000000 (arithmetic-shift b 16) (arithmetic-shift g 8) r))

;; Simplified function to switch to a colored scene (always recreates)
(define (switch-to-scene scene-name color-hex)
  (printf "→ ~a\n" scene-name)
  
  ;; Remove scene if it exists (ignore errors)
  (with-handlers ([exn:fail? (lambda (e) 
                               (printf "Remove failed: ~a\n" (exn-message e)))])
    (obs!scene-remove #:name scene-name))
  (obs!sleep #:secs 0.2)  ; Wait for removal to complete
  
  ;; Create the scene
  (obs!scene-create #:name scene-name)
  (obs!sleep #:secs 0.3)  ; Wait for scene creation
  
  ;; Create scene with these properties
  (define source-name (string-append scene-name " Color"))
  (with-handlers ([exn:fail? (lambda (e) 
                               (printf "Color source creation failed for ~a: ~a\n" 
                                       scene-name (exn-message e)))])
    (obs!input-create #:scene scene-name #:name source-name #:kind "color_source_v3")
    (obs!sleep #:secs 0.2)  ; Wait for source creation
    (obs!input-set-settings #:input source-name 
                            #:settings (hasheq 'color (hex-to-obs-color color-hex)))
    (obs!sleep #:secs 0.2)) ; Wait for settings to apply
  
  ;; Switch to scene
  (obs!scene-switch #:to scene-name)
  (obs!sleep #:secs 0.1)) ; Brief pause before next operation

;; Macro to cycle through colored scenes
(define-syntax-rule (cycle-scenes (scene-name color-hex) ...)
  (begin (switch-to-scene scene-name color-hex) ...))

;; Define scenes and run rapid color transitions
(define scenes '(("Red" "#FF0000") 
                 ("Blue" "#0000FF") 
                 ("Green" "#00FF00") 
                 ("Yellow" "#FFFF00") 
                 ("Purple" "#800080") 
                 ("Orange" "#FFA500")
                 ("Pink" "#FFC0CB") 
                 ("Cyan" "#00FFFF") 
                 ("Magenta" "#FF00FF") 
                 ("Lime" "#32CD32")))

(printf "\n=== Starting Recording and Transitions ===\n")
(obs!record-start)

(for ([cycle (in-range 1)])
  (printf "Cycle ~a:\n" (+ cycle 1))
  (for ([scene scenes])
    (switch-to-scene (list-ref scene 0) (list-ref scene 1))))

(obs!record-stop)
(printf "\nDemo Complete!\n")
