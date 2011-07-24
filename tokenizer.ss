(define output "author. (year). title. container-title, volume(issue), page.")
(define variables (list "author" "year" "title" "container-title" "volume" "issue" "page"))

(define (starts-with-variable str variable-list) (let
	(
		(first-variable (car variable-list))
	)
	
	(if
		(and
			(<= (string-length first-variable) (string-length str))
			(string=? (substring str 0 (string-length first-variable)) first-variable)
		)
		first-variable
		(if (= (length variable-list) 1) #f (starts-with-variable str (cdr variable-list)))
	)
))

(define (tokenize str) (if (string=? str "")
	'()
	(let
		(
			(first-variable (starts-with-variable str variables))
		)
		
		(if (string? first-variable)
			(append (list first-variable) (tokenize (substring str (string-length first-variable) (string-length str))))
			(append (list (substring str 0 1)) (tokenize (substring str 1 (string-length str))))
		)
	)
))

(pretty-print (tokenize output))

(exit)