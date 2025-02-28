;; Temporal Energy Recycling Contract

(define-map energy-taps
  { id: uint }
  {
    loop-id: uint,
    energy: uint
  }
)

(define-data-var next-tap-id uint u0)

(define-public (create-tap (loop-id uint))
  (let
    ((new-id (+ (var-get next-tap-id) u1)))
    (var-set next-tap-id new-id)
    (ok (map-set energy-taps
      { id: new-id }
      {
        loop-id: loop-id,
        energy: u0
      }
    ))
  )
)

(define-public (extract-energy (tap-id uint) (amount uint))
  (match (map-get? energy-taps { id: tap-id })
    tap (ok (map-set energy-taps
      { id: tap-id }
      {
        loop-id: (get loop-id tap),
        energy: (+ (get energy tap) amount)
      }
    ))
    (err u404)
  )
)

(define-read-only (get-tap (id uint))
  (map-get? energy-taps { id: id })
)

