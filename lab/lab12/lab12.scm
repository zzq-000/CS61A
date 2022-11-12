
(define-macro (def func args body)
  (list 'define (cons func args) body)
)


(define (map-stream f s)
    (if (null? s)
    	nil
    	(cons-stream (f (car s)) (map-stream f (cdr-stream s)))))

(define all-three-multiples
  (begin (define (integer n)
    (cons-stream n (integer (+ n 1)))
  )
  (map-stream (lambda (x) (* x 3)) (integer 1)))
)


(define (compose-all funcs)
  (if (null? funcs)
      (lambda (x) x)
      (lambda (x) ((compose-all (cdr funcs)) ((car funcs) x)))
  )
)


(define (partial-sums stream)
  (define (helper result stream)
    (if (null? stream)
        nil
        (cons-stream (+ result (car stream)) (helper (+ result (car stream)) (cdr-stream stream)))
    )
  )
  (helper 0 stream)
)

