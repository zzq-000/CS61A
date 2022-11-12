(define (rle s)
  (define (helper n count s)
    (if (null? s)
        (cons-stream (list n count) nil)
        (if (= (car s) n)
            (helper n (+ count 1) (cdr-stream s))
            (cons-stream (list n count) (helper (car s) 1 (cdr-stream s)))
        )

    )
  )
  (if (null? s)
    nil
    (helper (car s) 0 s)
  )
)



(define (group-by-nondecreasing s)
    (define (helper tresult pre s)
        (if (null? s)
            (cons-stream tresult nil)
            (if (or (equal? tresult nil) (<= pre (car s)))
                (helper (append tresult (list (car s))) (car s) (cdr-stream s))
                (cons-stream tresult (helper nil (car s) s))
            )

        )
    )
    (helper nil 0 s)
)


(define finite-test-stream
    (cons-stream 1
        (cons-stream 2
            (cons-stream 3
                (cons-stream 1
                    (cons-stream 2
                        (cons-stream 2
                            (cons-stream 1 nil))))))))

(define infinite-test-stream
    (cons-stream 1
        (cons-stream 2
            (cons-stream 2
                infinite-test-stream))))

