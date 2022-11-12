(define (cddr s)
  (cdr (cdr s)))

(define (cadr s)
  (car (cdr s))
)

(define (caddr s)
  (car (cddr s))
)


(define (sign num)
  (cond
      ((< num 0) -1)
      ((= num 0) 0)
      ((> num 0) 1)
      )
)


(define (square x) (* x x))

(define (pow x y)
(if (= y 0)
    1
    (if (= (modulo y 2) 0)
      (square (pow x (/ y 2)))
      (* x (square (pow x (/ (- y 1) 2))))
      )
  )
  
)


(define (unique s)
    
    (define (remove item s)
        (if (null? s)
            s
            (if (equal? item (car s))
                (remove item (cdr s))
                (cons (car s) (remove item (cdr s)))
                )
            )
        )
    (if (null? s)
        s
        (cons (car s) (unique (remove (car s) s)))
    )
)


(define (replicate x n)
    (define (helper s x n)
        (if (= n 0)
            s
            (helper (cons x s) x (- n 1))
            )
        )
    (helper nil x n)
  )


(define (accumulate combiner start n term)
  (if (= n 0)
      start
      (accumulate combiner (combiner start (term n)) (- n 1) term)
      )
)


(define (accumulate-tail combiner start n term)
  (if (= n 0)
      start
      (accumulate-tail combiner (combiner start (term n)) (- n 1) term)
      )
)


(define-macro (list-of map-expr for var in lst if filter-expr)
  (list 'map (list 'lambda (list var) map-expr) (list 'filter (list 'lambda (list var) filter-expr) lst ))
)

