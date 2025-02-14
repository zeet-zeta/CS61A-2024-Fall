(define (cadr s) (car (cdr s)))

(define (ascending? s) 
  (if (null? s)
      #t
      (if (null? (cdr s))
          #t
          (if (<= (car s) (cadr s))
              (ascending? (cdr s))
              #f))))

(define (my-filter pred s) 
  (if (null? s)
      '()
      (if (pred (car s))
          (cons (car s) (my-filter pred (cdr s)))
          (my-filter pred (cdr s)))))

(define (interleave lst1 lst2) 
  (if (null? lst1)
      lst2
      (cons (car lst1) (interleave lst2 (cdr lst1)))))

(define (no-repeats s) 
  (if (null? s)
      '()
      (cons (car s) (my-filter (lambda (x) (not (= x (car s)))) (no-repeats (cdr s))))))
