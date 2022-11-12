(define (split-at lst n)
  (define (helper first index lst n)
	(if (or (null? lst) (= index n))
		(cons first lst)
		(helper (append first (list (car lst))) (+ index 1) (cdr lst) n)
	)
  )
  (helper nil 0 lst n)
)


(define-macro (switch expr cases)
	(cons _________
		(map (_________ (_________) (cons _________ (cdr case)))
    			cases))
)

