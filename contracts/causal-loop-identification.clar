;; Causal Loop Identification Contract

(define-map causal-loops
  { id: uint }
  {
    description: (string-utf8 256),
    severity: uint
  }
)

(define-data-var next-loop-id uint u0)

(define-public (detect-loop (description (string-utf8 256)) (severity uint))
  (let
    ((new-id (+ (var-get next-loop-id) u1)))
    (var-set next-loop-id new-id)
    (ok (map-set causal-loops
      { id: new-id }
      {
        description: description,
        severity: severity
      }
    ))
  )
)

(define-read-only (get-loop (id uint))
  (map-get? causal-loops { id: id })
)

