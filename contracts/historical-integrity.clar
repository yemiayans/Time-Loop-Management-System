;; Historical Integrity Contract

(define-map historical-events
  { id: uint }
  {
    description: (string-utf8 256),
    timestamp: uint,
    integrity: uint
  }
)

(define-data-var next-event-id uint u0)

(define-public (record-event (description (string-utf8 256)) (timestamp uint) (integrity uint))
  (let
    ((new-id (+ (var-get next-event-id) u1)))
    (var-set next-event-id new-id)
    (ok (map-set historical-events
      { id: new-id }
      {
        description: description,
        timestamp: timestamp,
        integrity: integrity
      }
    ))
  )
)

(define-read-only (get-event (id uint))
  (map-get? historical-events { id: id })
)

