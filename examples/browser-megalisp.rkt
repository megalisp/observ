;; browser-megalisp.rkt - Create a full-screen browser source for megalisp GitHub
;; Load this file with: (obs!load #:file "examples/browser-megalisp.rkt")

(require racket/string)

;; Configuration
(define SCENE-NAME "Megalisp Browser")
(define SOURCE-NAME "Megalisp GitHub")
(define URL "https://github.com/megalisp")
(define WIDTH 1920)   ; Full HD width - adjust as needed
(define HEIGHT 1080)  ; Full HD height - adjust as needed

;; Clean setup macro with error handling
(define-syntax-rule (setup-browser-scene)
  (begin
    (printf "=== Setting up Megalisp Browser Scene ===\n")
    
    ;; Remove existing scene if it exists
    (with-handlers ([exn:fail? (lambda (e) (printf "Scene didn't exist, creating new...\n"))])
      (obs!scene-remove #:name SCENE-NAME)
      (obs!sleep #:secs 0.3))
    
    ;; Create the scene
    (printf "Creating scene: ~a\n" SCENE-NAME)
    (obs!scene-create #:name SCENE-NAME)
    (obs!sleep #:secs 0.3)
    
    ;; Create browser source with settings
    (printf "Creating browser source: ~a\n" SOURCE-NAME)
    (printf "URL: ~a\n" URL)
    (printf "Size: ~ax~a\n" WIDTH HEIGHT)
    
    (with-handlers ([exn:fail? (lambda (e) (printf "Failed to create browser source: ~a\n" (exn-message e)))])
      (obs!input-create #:scene SCENE-NAME 
                        #:name SOURCE-NAME 
                        #:kind "browser_source"
                        #:settings (hasheq 'url URL
                                          'width WIDTH
                                          'height HEIGHT
                                          'fps 30
                                          'restart_when_active #t
                                          'shutdown #t
                                          'css "body { margin: 0; overflow: hidden; }")))
    (obs!sleep #:secs 0.5)
    
    ;; Switch to the new scene
    (printf "Switching to scene: ~a\n" SCENE-NAME)
    (obs!scene-switch #:to SCENE-NAME)
    (obs!sleep #:secs 0.3)
    
    (printf "\n=== Browser Setup Complete! ===\n")
    (printf "Now showing: ~a\n" URL)
    (printf "Scene: ~a\n" SCENE-NAME)
    (printf "Source: ~a\n" SOURCE-NAME)))

;; Utility macro to refresh the browser
(define-syntax-rule (refresh-browser)
  (begin
    (printf "Refreshing browser source...\n")
    (with-handlers ([exn:fail? (lambda (e) (printf "Failed to refresh: ~a\n" (exn-message e)))])
      ;; Refresh by toggling the source visibility
      (obs!input-set-settings #:input SOURCE-NAME
                              #:settings (hasheq 'restart_when_active #t)))
    (printf "Browser refreshed!\n")))

;; Utility macro to change URL
(define-syntax-rule (change-url new-url)
  (begin
    (printf "Changing URL to: ~a\n" new-url)
    (with-handlers ([exn:fail? (lambda (e) (printf "Failed to change URL: ~a\n" (exn-message e)))])
      (obs!input-set-settings #:input SOURCE-NAME
                              #:settings (hasheq 'url new-url)))
    (printf "URL changed!\n")))

;; Run the setup
(setup-browser-scene)

;; Optional: Demonstrate URL changing after a few seconds
(printf "\nWaiting 5 seconds before demonstrating URL change...\n")
(obs!sleep #:secs 3)
(printf "\nSwitching to observ repository...\n")
(change-url "https://github.com/megalisp/observ")
(obs!sleep #:secs 3)

(printf "\nBack to main megalisp page...\n")
(change-url "https://github.com/megalisp")

(printf "\n=== Demo Complete! ===\n")
(printf "Browser source is now showing the megalisp GitHub page!\n")
(printf "You can use (change-url \"new-url\") to navigate elsewhere.\n")
(printf "You can use (refresh-browser) to refresh the page.\n")
