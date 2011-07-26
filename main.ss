;; ***** BEGIN LICENSE BLOCK *****
;; 
;; Copyright © 2011 Simon Kornblith
;; 
;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU Affero General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.
;; 
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU Affero General Public License for more details.
;; 
;; You should have received a copy of the GNU Affero General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.
;; 
;; ***** END LICENSE BLOCK *****

(import (church))

;; BEGIN CHURCH
(church

;; This was generated using tokenizer.ss, which can't run within Church. You will need to rerun
;; to tokenize another style.
(define output (list "author" "." " " "(" "year" ")" "." " " "title" "." " "
  "container-title" "," " " "volume" "(" "issue" ")" "," " "
  "page" "."))

;;
;; DATA FOR INFERENCE
;;

;; The probabilities of observing each of these characters in a prefix/suffix or a delimiter are
;; estimated based upon the styles present in the CSL repository. We separate individual characters
;; rather than leaving the prefix/suffix intact so that noisy-lev-list-equal? will be accurate.
(define delimiter-list (list 
	(pair '() 2178)
	(pair (list " ") 1121)
	(pair (list " " ":" " ") 3)
	(pair (list " " "'") 1)
	(pair (list "," " ") 1134)
	(pair (list "." " ") 279)
	(pair (list ":" " ") 1)
	(pair (list ":" " ") 314)
	(pair (list ",") 11)
	(pair (list "/") 3)
	(pair (list ".") 7)
	(pair (list " " ";" " ") 1)
	(pair (list " " ";" " ") 1)
	(pair (list ";" " ") 29)
	(pair (list ";") 15)
	(pair (list ":") 35)
	(pair (list "_") 2)
))
(define prefix-list (list 
	(pair '() 9693)
	(pair (list "," " " "," " " "," " ") 11)
	(pair (list " " "-" " ") 3)
	(pair (list "/" "/" " ") 6)
	(pair (list "," " " "," " " "," " " "," " " "," " " "," " ") 6)
	(pair (list ";" " " ":") 1)
	(pair (list ":" " ") 82)
	(pair (list " " " " "-" " ") 2)
	(pair (list " " ":" " ") 2)
	(pair (list ":" " " ":" " ") 4)
	(pair (list "." " " "-" " ") 2)
	(pair (list " ") 1239)
	(pair (list " " "/" "/" " ") 1)
	(pair (list "\"") 209)
	(pair (list "," " ") 417)
	(pair (list "." " ") 278)
	(pair (list "(") 154)
	(pair (list "-") 2)
	(pair (list ",") 8)
	(pair (list "/") 1)
	(pair (list ".") 6)
	(pair (list " " "[") 49)
	(pair (list ";") 2)
	(pair (list ":") 89)
	(pair (list "." " " "." " " "." " ") 3)
	(pair (list "<") 19)
	(pair (list " " "\"") 1)
	(pair (list "." " " "<") 2)
	(pair (list " " " ") 156)
	(pair (list " " "(" " " "(") 4)
	(pair (list " " "'") 1)
	(pair (list "," " " "," " " "," " " "," " ") 9)
	(pair (list " " "(") 181)
	(pair (list " " "(" "=" " ") 4)
	(pair (list "," " " " ") 2)
	(pair (list ";" " ") 31)
	(pair (list "." " " "." " ") 2)
	(pair (list "." " " "(") 3)
	(pair (list "[") 102)
	(pair (list " " "<") 11)
	(pair (list "," " " "," " ") 12)
	(pair (list "'") 7)
	(pair (list " " " " "(") 2)
	(pair (list "," " " "," " " "," " " "," " " "," " ") 6)
	(pair (list "," " " "<") 2)
	(pair (list " " "." " " "." " ") 3)
	(pair (list "{") 1)
))
(define suffix-list (list 
	(pair '() 10189)
	(pair (list ")" ":") 2)
	(pair (list "]" "." " ") 3)
	(pair (list "]" ":" " ") 4)
	(pair (list ":" " ") 100)
	(pair (list " " ":" " ") 12)
	(pair (list ")" ")") 2)
	(pair (list "'") 7)
	(pair (list ")" "," " ") 1)
	(pair (list ":" " " ":" " ") 2)
	(pair (list ")" ",") 2)
	(pair (list ")" ".") 14)
	(pair (list ">" " ") 2)
	(pair (list ")" " ") 9)
	(pair (list "." "'") 1)
	(pair (list ">" "." " ") 2)
	(pair (list " ") 161)
	(pair (list ")" ":" " " " ") 1)
	(pair (list "\"") 185)
	(pair (list "," "\"") 6)
	(pair (list "." ".") 49)
	(pair (list "." " ") 374)
	(pair (list ")" "." " ") 4)
	(pair (list ",") 115)
	(pair (list "/") 1)
	(pair (list ".") 1157)
	(pair (list ";") 17)
	(pair (list ":") 41)
	(pair (list "." " " "." " " "." " ") 3)
	(pair (list ">") 41)
	(pair (list " " "\"") 8)
	(pair (list "." "." ".") 18)
	(pair (list " " " ") 1)
	(pair (list "'" "," " ") 1)
	(pair (list ";" ";") 2)
	(pair (list "," " " "\"") 5)
	(pair (list "." "." " ") 3)
	(pair (list "." "," " ") 4)
	(pair (list ";" " ") 69)
	(pair (list "." " " "." " ") 2)
	(pair (list "," "," ".") 3)
	(pair (list "-" " ") 1)
	(pair (list "." ",") 12)
	(pair (list "]") 134)
	(pair (list "." " " " ") 2)
	(pair (list "." " " "\"") 1)
	(pair (list "," " " "," " ") 2)
	(pair (list "," " ") 220)
	(pair (list "," "\"" " ") 5)
	(pair (list "." "," "." ",") 6)
	(pair (list "." "." "." ".") 5)
	(pair (list ")") 313)
	(pair (list "." " " ".") 3)
	(pair (list "]" " ") 16)
	(pair (list "]" ".") 1)
	(pair (list "}") 21)
))
(define variable-list (list "author" "year" "title" "container-title" "volume" "issue" "page"))

;; Extract weights from pairs above
(define delimiter-weights (map rest delimiter-list))
(define prefix-weights (map rest prefix-list))
(define suffix-weights (map rest suffix-list))

;;
;; GENERAL PURPOSE FUNCTIONS
;;

;; shift the first n items off the list l
(define (shift-n l n)
	(rest
		(if (= n 1)
			l
			(shift-n l (- n 1))
		)
	)
)

;; return the first n items of the list l
(define (first-n l n)
	(if (= n 1)
		(list (first l))
		(append (list (first l)) (first-n (rest l) (- n 1)))
	)
)

;; add a delimiter after every occurence of a string in a list
(define (delimiter-join strings delimiter)
	(if (= (length delimiter) 0)
		strings
		(if (= (length strings) 1)
			(list (first strings))
			(append (list (first strings) delimiter) (delimiter-join (rest strings) delimiter))
		)
	)
)

;; substr function
(define (substr str start length)
	(string (map (lambda (x) (string-ref str x)) (range start (+ start (- length 1)))))
)

;;
;; SYNTACTIC SUGAR FOR DATA
;;

;; each token is a list containing a prefix, suffix, and variable name, and optional data
;; containing additional information
(define (prefix token) (first (list-ref prefix-list (first token))))
(define (suffix token) (first (list-ref suffix-list (second token))))
(define (variable token) (list-ref variable-list (third token)))
(define (is-group token) (= (third token) -1))
(define (token-data token) (fourth token))

;; groups are tokens whose optional data (fourth element) is a list containing a delimiter and a
;; token-list
(define (delimiter group) (first (list-ref delimiter-list (first (token-data group)))))
(define (group-token-list group) (second (token-data group)))

;;
;; GENERATIVE MODEL AND FORMATTER
;;

;; recursive function to generate citation tokens
(define (get-style available-variables)
	(list
		(list
			(sample-discrete prefix-weights) (sample-discrete suffix-weights) -1
			(list
				(sample-discrete delimiter-weights)
				(get-style-children available-variables)
			)
		)
	)
)

(define (get-style-children available-variables) 
	(let
		(
			(prefix-index (sample-discrete prefix-weights))
			(suffix-index (sample-discrete suffix-weights))
			(n-available-variables (length available-variables))
		)
		
		;; if there are more than two variables left, we might want to use a group
		(if (and (> n-available-variables 1) (flip 0.1))
			;; group
			(let*
				(
					(n-variables-in-group (+ (sample-integer (- (length available-variables) 1)) 2))
					(token-list
						(list
							(list
								prefix-index suffix-index -1
								(list
									(sample-discrete delimiter-weights)
									(get-style-children (first-n available-variables n-variables-in-group))
								)
							)
						)
					)
				)
				(if
					(= (- n-available-variables n-variables-in-group) 0)
					token-list
					(append token-list (get-style-children (shift-n available-variables n-variables-in-group)))
				)
			)
			
			;; ordinary token
			(let
				(
					(token-list (list (list prefix-index suffix-index (first available-variables))))
				)
				(if
					(= n-available-variables 1)
					token-list
					(append token-list (get-style-children (rest available-variables)))
				)
			)
		)
	)
)

;; for formatting style output
(define (format-token token)
	(append
		(prefix token)
		(if (is-group token)
			(delimiter-join (map format-token (group-token-list token)) (delimiter token))
			(list (variable token))
		)
		(suffix token)
	)
)
(define (format-tokens token-list) (flatten (map format-token token-list)))

;; for displaying inferred styles
(define (display-token token)
	(append
		(list (apply string-append (prefix token)))
		(if (is-group token)
			(list (list "group" (apply string-append (delimiter token)) (map display-token (group-token-list token))))
			(list (variable token))
		)
		(list (apply string-append (suffix token)))
	)
)
(define (display-tokens token-list) (map display-token token-list))

;; for generating CSL
(define (quote-marks strlist) (apply string-append (map (lambda (x) (if (equal? x "\"") "\\\"" x)) strlist)))

(define (display-token-xml token)
	(string-append
		(if (is-group token)
			(apply string-append (list
				"<group"
				(if (= (length (delimiter token)) 0)
					""
					(string-append " delimiter=\"" (quote-marks (delimiter token)) "\"")
				)
			))
			(string-append "<text variable=\"" (variable token) "\""))
		(if (= (length (prefix token)) 0) "" (string-append " prefix=\"" (quote-marks (prefix token)) "\""))
		(if (= (length (suffix token)) 0) "" (string-append " suffix=\"" (quote-marks (suffix token)) "\""))
		(if (is-group token)
			(string-append ">" (apply string-append (map display-token-xml (group-token-list token))) "</group>")
			"/>"
		)
	)
)

(define (display-xml token-list) (map display-token-xml token-list))

;;
;; PERFORM INFERENCE
;;
(define samples (mh-query
	10
	1000
	
	;; generate a token list
	;(define style (get-style (sample-index-permutation (length variable-list))))
	(define style (get-style (range 0 (- (length variable-list) 1))))
	(define this-output (format-tokens style))
	
	;; return styles
	style
	
	;; condition on producing the correct output
	(if (equal? this-output output) true (noisy-lev-list-equal? this-output output 1e-20))
))

;;
;; SHOW RESULTS
;; 
(display (apply string-append (map (lambda (x) (string-append x "\n")) (map (lambda (sample) (apply string-append (format-tokens sample))) samples))))
(pretty-print (map display-tokens samples))
(last (map display-xml samples))


;; END CHURCH
)

(exit)