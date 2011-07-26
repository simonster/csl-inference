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