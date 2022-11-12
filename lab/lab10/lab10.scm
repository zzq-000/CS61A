(define (over-or-under num1 num2)
  (if (> num1 num2)
      1
      (if (= num1 num2)
          0
          -1
      )
  )
)

;;; Tests
(over-or-under 1 2)
; expect -1
(over-or-under 2 1)
; expect 1
(over-or-under 1 1)
; expect 0


(define (filter-lst fn lst)
  (if (> (length lst) 0)
      (if (fn (car lst))
          (cons (car lst) (filter-lst fn (cdr lst)))
          (filter-lst fn (cdr lst))
      )
      nil
  )
)

;;; Tests
(define (even? x)
  (= (modulo x 2) 0))
(filter-lst even? '(0 1 1 2 3 5 8))
; expect (0 2 8)


(define (make-adder num)
  (lambda (x) (+ x num))
)

;;; Tests
(define adder (make-adder 5))
(adder 8)
; expect 13


(define lst (list (list 1) 2 (list 3 4) 5))
;(define lst
;  (cons (cons 1 nil) (cons 2 (cons (cons 3 (cons 4 nil)) (cons 5 nil))))
;)



(define (composed f g)
  (lambda (x) (f (g x)))
)


(define (remove item lst)
  (define (ne x) (not (= x item)))
  (filter-lst ne lst)
)


;;; Tests
(remove 3 nil)
; expect ()
(remove 3 '(1 3 5))
; expect (1 5)
(remove 5 '(5 3 5 5 1 4 5 4))
; expect (3 1 4 4)



;(define (no-repeats s)
;  (define (in_lst item lst)
;    (if (> (length lst) 0)
;        (if (= item (car lst))
;            #f
;            (in_lst item (cdr lst))       
;        )
;        #t
;    )
;  )
;  filter-lst(in_lst s)
;)
(define (no-repeats s)
  
	(if (> (length s) 0)
    (cons (car s) (no-repeats (remove (car s) (cdr s))))
    nil
  )
)


(define (substitute s old new)
  (if (null? s)
    nil
    (if (pair? (car s))
      (cons (substitute (car s) old new) (substitute (cdr s) old new))
      (if (eq? (car s) old)
        (cons new (substitute (cdr s) old new))
        (cons (car s) (substitute (cdr s) old new))
      )
    )
  )
)


(define (sub-all s olds news)
  (if (null? olds)
    s
    (sub-all (substitute s (car olds) (car news)) (cdr olds) (cdr news))
  )
)



(define (my-append a b)
  (define (single-append a b)
    (if (null? a)
      (cons b nil)
      (cons (car a) (single-append (cdr a) b))
    )  
  )
  (if (null? b)
    a
    (my-append (single-append a (car b)) (cdr b))
  )
)

(define (insert element lst index)
  (if (= index 0)
    (append (list element) lst)
    (cons (car lst) (insert element (cdr lst) (- index 1)))

  )
)

(define (duplicate lst)
  (if (null? lst)
    nil
    (cons (car lst) (cons (car lst) (duplicate (cdr lst))))
  )
)

(define (reverse lst)
  (define (reverse-helper lst tail)
    (if (null? lst)
        tail
        (reverse-helper (cdr lst) (cons (car lst) tail))
    )
  )
  (reverse-helper lst nil)
)

(define (insert n lst)
  (if (null? lst)
      (cons n nil)
      (if (> (car lst) n)
        (cons n lst)
        (cons (car lst) (insert n (cdr lst)))
      )
  )
)

(define-macro (prune-expr expr)
  (define (helper lst)
    (if (<= (length lst) 1)
      lst
      (cons (car lst) (helper (cdr (cdr lst))))
    )
  )
  (cons (car expr) (helper (cdr expr)))

)

(define-macro (when condition exprs)
(list 'if condition
          (cons 'begin exprs)
        ''okay
)
)

(define-macro (when condition exprs)
  (define (process exprs)
    (cons 'begin exprs)
  )
  (define result (process exprs))
`(if ,condition (,result) 'okay)
)

