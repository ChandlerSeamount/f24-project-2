(load "project-2.lisp")

(defun pred-prop (x turn)
    (if (not-p x)
        (cons 'not (list (pred-prop (second x) turn)))
        (let ((prop (with-output-to-string (my-int) (princ turn my-int))))
    (labels ((h (y str)
    (if (null y)
    str
    (concatenate 'string (symbol-name (car y)) "-" 
    (h (cdr y) str)))))
    (intern (h x prop))))
    )
)
(defun pred-bool (x turn)
    
    (labels ((h (y)
    (if (null y)
        nil
        (cons-new (pred-prop (car y) turn) (h (cdr y))))))
    (cons 'and (h x)))
)

(defun pred-prop-action (x turn d p d1 d2 act)
    (if (not-p x)
        (cons 'not (list (pred-prop-action (second x) turn d p d1 d2 act)))
        (let ((prop (with-output-to-string (my-int) (princ turn my-int))))
    (labels ((h (y str)
    (cond ((null y) str)
    ((eq (car y) '?disk) (concatenate 'string (symbol-name d) "-" (h (cdr y) str)))
    ((eq (car y) '?peg) (concatenate 'string (symbol-name p) "-" (h (cdr y) str)))
    ((eq (car y) '?disk1) (concatenate 'string (symbol-name d1) "-" (h (cdr y) str)))
    ((eq (car y) '?disk2) (concatenate 'string (symbol-name d2) "-" (h (cdr y) str)))
    (t (concatenate 'string (symbol-name (car y)) "-" (h (cdr y) str)))
    )))
    (intern (h x prop))))
    )
)

(defun pred-bool-action (x turn d p d1 d2 act)
    
    (labels ((h (y)
    (if (null y)
        nil
        (cons-new (pred-prop-action (car y) turn d p d1 d2 act) (h (cdr y))))))
    (h x))
)

(defun val-bool (d p d1 d2 pre eff turn act pars)
    ; (if (null eff)
    ; (if (null pre)
    ; nil
    ; (append (pred-bool-action pre turn d p d1 d2))))
    (let ((prop (with-output-to-string (my-int) (princ turn my-int))))
        (labels ((h (y str)
    (cond ((null y) str)
    ((eq (car y) '?disk) (concatenate 'string (symbol-name d) "-" (h (cdr y) str)))
    ((eq (car y) '?peg) (concatenate 'string (symbol-name p) "-" (h (cdr y) str)))
    ((eq (car y) '?disk1) (concatenate 'string (symbol-name d1) "-" (h (cdr y) str)))
    ((eq (car y) '?disk2) (concatenate 'string (symbol-name d2) "-" (h (cdr y) str)))
    (t (h (cdr y) str))
    )))
    ; (intern (h x prop))
(let ((l (cons 'and (append (pred-bool-action pre turn d p d1 d2 act) (pred-bool-action eff (+ 1 turn) d p d1 d2 act)))))
        (list ':implies (intern (concatenate 'string (symbol-name act) "-" (h pars prop))) l))
        ; (append (list ':implies (intern (concatenate 'string (symbol-name act) "-" (h pars prop)))) '(list l)))
)    ; (append (list ':implies (intern (concatenate 'string (symbol-name act) "-" (h pars prop)))) (list (cons 'and (append (pred-bool-action pre turn d p d1 d2 act) (pred-bool-action eff (+ 1 turn) d p d1 d2 act))))))
    ; (append (:implies (intern (concatenate 'string (symbol-name act) "-" (symbol-name d)))) (list (cons 'and (append (pred-bool-action pre turn d p d1 d2 act) (pred-bool-action eff (+ 1 turn) d p d1 d2 act)))))
))

(defun for-every-ds (d p pre eff turn act pars)
    (list (val-bool d p 'd1 'd2 pre eff turn act pars) (val-bool d p 'd2 'd1 pre eff turn act pars))
)

(defun for-every-p (pre eff turn act pars)
    (if (eq (car pars) '?disk)
    (append (for-every-d 'p1 pre eff turn act pars) (for-every-d 'p2 pre eff turn act pars) (for-every-d 'p3 pre eff turn act pars))
    (append (for-every-ds 'd1 'p1 pre eff turn act pars) (for-every-ds 'd1 'p2 pre eff turn act pars) (for-every-ds 'd1 'p3 pre eff turn act pars)))
    ; (append (for-every-ds d 'p1 pre eff turn act pars) (for-every-ds d 'p2 pre eff turn act pars) (for-every-ds d 'p3 pre eff turn act pars))
)

(defun for-every-d (p pre eff turn act pars)
    (list (val-bool 'd1 p 'd1 'd2 pre eff turn act pars) (val-bool 'd2 p 'd2 'd1 pre eff turn act pars))
    ; (if (null d)
    ; bools 
    ; (for-every-p (car )))
)

(defun actions-bool (actions turn)
    ; (let ((action (second (car actions))) (pre (cdr (fourth (car actions)))) (eff (cdr (fifth (car actions)))))
    ;     (cons (actions-bool (val-bool pre eff turn action)) bools)
    ; )
    (if (null actions)
    nil
    (let ((action (second (car actions))) (pars (car (cdr (third (car actions))))) (pre (cdr (car (cdr (fourth (car actions)))))) (eff (cdr (car (cdr (fifth (car actions)))))))
        ; (format t "~a~%~b~%" pre eff)
        
        (DELETE-DUPLICATES (append (for-every-p pre eff turn action pars) (actions-bool (cdr actions) turn)))
    ))
)

(defun val-bool1 (d p d1 d2 pre eff turn act pars )
    ; (if (null eff)
    ; (if (null pre)
    ; nil
    ; (append (pred-bool-action pre turn d p d1 d2))))
    (let ((prop (with-output-to-string (my-int) (princ turn my-int))))
        (labels ((h (y str)
    (cond ((null y) str)
    ((eq (car y) '?disk) (concatenate 'string (symbol-name d) "-" (h (cdr y) str)))
    ((eq (car y) '?peg) (concatenate 'string (symbol-name p) "-" (h (cdr y) str)))
    ((eq (car y) '?disk1) (concatenate 'string (symbol-name d1) "-" (h (cdr y) str)))
    ((eq (car y) '?disk2) (concatenate 'string (symbol-name d2) "-" (h (cdr y) str)))
    (t (h (cdr y) str))
    )))
    ; (intern (h x prop))
    (intern (concatenate 'string (symbol-name act) "-" (h pars prop)))
; (let ((l (cons 'and (append (pred-bool-action pre turn d p d1 d2 act) (pred-bool-action eff (+ 1 turn) d p d1 d2 act)))))
;         (list ':implies (intern (concatenate 'string (symbol-name act) "-" (h pars prop))) l))
        ; (append (list ':implies (intern (concatenate 'string (symbol-name act) "-" (h pars prop)))) '(list l)))
)    ; (append (list ':implies (intern (concatenate 'string (symbol-name act) "-" (h pars prop)))) (list (cons 'and (append (pred-bool-action pre turn d p d1 d2 act) (pred-bool-action eff (+ 1 turn) d p d1 d2 act))))))
    ; (append (:implies (intern (concatenate 'string (symbol-name act) "-" (symbol-name d)))) (list (cons 'and (append (pred-bool-action pre turn d p d1 d2 act) (pred-bool-action eff (+ 1 turn) d p d1 d2 act)))))
))

(defun for-every-d1 (p pre eff turn act pars)
    (list (val-bool1 'd1 p 'd1 'd2 pre eff turn act pars) (val-bool1 'd2 p 'd2 'd1 pre eff turn act pars))
    ; (if (null d)
    ; bools 
    ; (for-every-p (car )))
)

(defun for-every-ds1 (d p pre eff turn act pars)
    (list (val-bool1 d p 'd1 'd2 pre eff turn act pars) (val-bool1 d p 'd2 'd1 pre eff turn act pars))
)

(defun for-every-p1 (pre eff turn act pars)
    (if (eq (car pars) '?disk)
    (append (for-every-d1 'p1 pre eff turn act pars) (for-every-d1 'p2 pre eff turn act pars) (for-every-d1 'p3 pre eff turn act pars))
    (append (for-every-ds1 'd1 'p1 pre eff turn act pars) (for-every-ds1 'd1 'p2 pre eff turn act pars) (for-every-ds1 'd1 'p3 pre eff turn act pars)))
    ; (append (for-every-ds d 'p1 pre eff turn act pars) (for-every-ds d 'p2 pre eff turn act pars) (for-every-ds d 'p3 pre eff turn act pars))
)

(defun get-all-actions (actions turn)
    (if (null actions)
    nil
    (let ((action (second (car actions))) (pars (car (cdr (third (car actions))))) (pre (cdr (car (cdr (fourth (car actions)))))) (eff (cdr (car (cdr (fifth (car actions)))))))
        ; (format t "~a~%~b~%" pre eff)
        
        (DELETE-DUPLICATES (append (for-every-p1 pre eff turn action pars) (get-all-actions (cdr actions) turn)))
    ))
)

(defun mutual-exclusion (actions turn)
    (let ((possible-actions (get-all-actions actions turn)))
        (labels ((h (poss-act act)
        (cond ((null poss-act) nil)
        ((eq (car poss-act) act) (h (cdr poss-act) act))
        (t (cons (list 'not (car poss-act)) (h (cdr poss-act) act)))))
        (h2 (poss-act)
        (if (null poss-act) nil
        (cons (list ':implies (car poss-act) (h possible-actions (car poss-act))) (h2 (cdr poss-act))))))
        (cons 'and (h2 possible-actions))
        )
    )
)

(defun turns (actions)
    (labels ((get-validity (turn)
    (if (> turn 5)
    nil
    (cons (actions-bool actions turn) (get-validity (+ 1 turn)))))
    (get-mutual (turn)
    (if (> turn 5)
    nil
    (cons (mutual-exclusion actions turn) (get-mutual (+ 1 turn)))))
    )
    (values (get-validity 0) (get-mutual 0)))
    
)

(defun get-outputs (actions)
(multiple-value-bind (val mut) (turns actions)
    (with-open-file (str "validity.txt"
                     :direction :output
                     :if-exists :supersede
                     :if-does-not-exist :create)
  (format str "~a" val))
  (with-open-file (str "mutual.txt"
                     :direction :output
                     :if-exists :supersede
                     :if-does-not-exist :create)
  (format str "~a" mut)))
  )

(let ((start '((onpeg d1 p1)
  		 (onpeg d2 p1)
  		 (on d1 d2)
  		 (ontable d2)
		 (clear d1)
		 (handempty)
  		 (isdisk d1)
  		 (isdisk d2)
  		 (issmaller d1 d2)
  		 (ispeg p1)
  		 (ispeg p2)
  		 (ispeg p3)
  		 (pegclear p2)
  		 (pegclear p3)))
         (goal '((onpeg d2 p3) (ontable d2) (on d1 d2)))
         (actions '(  (:action PickUp
	     (:parameters (?disk ?peg))
	     (:precondition (and (isdisk ?disk)
		 					(ispeg ?peg)
				 	        (clear ?disk)
				 	        (handempty)
							(onpeg ?disk ?peg)
				 	        (ontable ?disk)))
	     (:effect (and (not (handempty)) 
		 			  (not (clear ?disk))
		 			  (not (onpeg ?disk ?peg))
		 			  (holding ?disk)
		 			  (pegclear ?peg)
		 			  (not (ontable ?disk)))))
  (:action PutDown
	     (:parameters (?disk ?peg))
	     (:precondition (and (holding ?disk)
				 			(ispeg ?peg)
				 			(pegclear ?peg)))
	     (:effect (and (clear ?disk) 
		 			  (ontable ?disk)
		 			  (onpeg ?disk ?peg)
		 			  (not (pegclear ?peg))
		 			  (handempty)
		 			  (not (holding ?disk)))))
  (:action Unstack
	     (:parameters (?disk1 ?disk2 ?peg))
	     (:precondition (and (isdisk ?disk1)
		 					(ispeg ?peg)
				 	        (clear ?disk1)
				 	        (handempty)
							(onpeg ?disk1 ?peg)
				 			(on ?disk1 ?disk2)))
	     (:effect (and (clear ?disk2)
			   		  (not (clear ?disk1))
			   		  (not (on ?disk1 ?disk2))
			   		  (not (onpeg ?disk1 ?peg))
			   		  (holding ?disk1)
			   		  (not (handempty)))))  
  (:action Stack
	     (:parameters (?disk1 ?disk2 ?peg))
	     (:precondition (and (isdisk ?disk2)
				 			(ispeg ?peg)
							(clear ?disk2)
							(holding ?disk1)
							(issmaller ?disk1 ?disk2)
							(onpeg ?disk2 ?peg)))
	     (:effect (and (on ?disk1 ?disk2)
			   		  (onpeg ?disk1 ?peg)
					  (clear ?disk1)
					  (not (clear ?disk2))
		 			  (handempty)
		 			  (not (holding ?disk1))))))))
(format t "~a~%~b~%" (pred-bool start 0) (pred-bool goal 5)) 
; (format t "~a~%" (turns actions))
; (format t "~a~%" (sat-p (car (actions-bool actions 1))))
(get-outputs actions)
)


(exit)