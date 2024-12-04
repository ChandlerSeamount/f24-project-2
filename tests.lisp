(load "project-2.lisp")

(defun test (a b c)
    (format t "~A: " a)
    (if (equal b c)
    (format t "success~%")
    (format t "failure~% Output: ~a~%" b)))

(test "single var" (exp->nnf 'a) 'a)
(test "single neg" (exp->nnf '(not a)) '(not a))
(test "double neg" (exp->nnf '(not (not a))) 'a)

(test "iff" (exp->nnf '(:iff a b)) '(and (or (not a) b) (or (not b) a)))
(test "not iff" (exp->nnf '(not (:iff a b))) '(or (and a (not b)) (and b (not a))))

(test "implies" (exp->nnf '(:implies a b)) '(or (not a) b))
(test "not implies" (exp->nnf '(not (:implies a b))) '(and a (not b)))

(test "xor" (exp->nnf '(:xor a b)) '(and (or a b) (or (not a) (not b))))
(test "not xor" (exp->nnf '(not (:xor a b))) '(or (and (not a) (not b)) (and a b)))

(test "and" (exp->nnf '(and a b)) '(and a b))
(test "not and" (exp->nnf '(not (and a b))) '(or (not a) (not b)))

(test "or" (exp->nnf '(or a b)) '(or a b))
(test "not or" (exp->nnf '(not (or a (not b)))) '(and (not a) b))

(format t "~%")

(test "dist 1" (nnf->cnf '(or a (and b c))) '(and (or a b) (or a c)))
(test "dist 2" (nnf->cnf '(or x (and a b c))) '(and (or a x) (or b x) (or c x)))
(test "dist 3" (nnf->cnf '(or (or x y) (and b c))) '(and (or b x y) (or c x y)))
(test "dist 4" (nnf->cnf '(or (or x y z) (and b c))) '(and (or b x y z) (or c x y z)))

(format t "~%")

(test "dist 5" (nnf->cnf '(or (and x y) (and b c))) '(and (or b x) (or b y) (or c x) (or c y)))
(test "dist 6" (nnf->cnf '(or (and x y z) (and a b c))) '(and (or a x) (or a y) (or a z) (or b x) (or b y) (or b z) (or c x) (or c y) (or c z)))

(format t "~%")

; (multiple-value-bind (new_terms new_bindings) (dpll-unit-propagate (cdr (exp->cnf '(and (not p0) (or p1 p2)))) NIL)
; (test "max propagate leftover" new_terms '((or p1 p2)))
; (test "bin propagate leftover" new_bindings '((not p0))))
; (multiple-value-bind (new_terms new_bindings) (dpll-unit-propagate (cdr (exp->cnf '(and (not p0) (or p0 p2)))) NIL)
; (test "max propagate none" new_terms '())
; (test "bin propagate none" new_bindings '(p2 (not p0))))
; (multiple-value-bind (new_terms new_bindings) (dpll-unit-propagate (cdr (exp->cnf '(and (not p0) (:iff p1 p3) (:iff p1 p3)))) NIL)
; (test "max propagate iff" new_terms '((OR P3 (NOT P1)) (OR P1 (NOT P3)) (OR P3 (NOT P1)) (OR P1 (NOT P3))))
; (test "bin propagate iff" new_bindings '((not p0))))
; (multiple-value-bind (new_terms new_bindings) (dpll-unit-propagate (cdr (exp->cnf '(and (not p0) (not p2) (or p0 p2)))) NIL)
; (test "max propagate false" new_terms '())
; (test "bin propagate false" new_bindings '(p2 (not p0))))
; (multiple-value-bind (new_terms new_bindings) (dpll-unit-propagate (cdr (exp->cnf '(and a (or a b)))) NIL)
; (test "max propagate true" new_terms '((OR P3 (NOT P1)) (OR P1 (NOT P3)) (OR P3 (NOT P1)) (OR P1 (NOT P3))))
; (test "bin propagate true" new_bindings '((not p0))))
; (test "sat-0" (sat-p '(and (not p0) (:iff p1 p3) (:iff p1 p3))) 'a)

(multiple-value-bind (new_terms new_bindings) (dpll-unit-propagate (cdr (exp->cnf '(and a (or b (not a))))) NIL)
(test "propogate true 1" (check-bindings new_terms new_bindings) T))

(multiple-value-bind (new_terms new_bindings) (dpll-unit-propagate (cdr (exp->cnf '(and a (and b (not a))))) NIL)
(test "propogate false 1" (check-bindings new_terms new_bindings) Nil))

(multiple-value-bind (new_terms new_bindings) (dpll-unit-propagate (cdr (exp->cnf '(and a (or b (not c))))) NIL)
(test "propogate leftover terms" new_terms '((or b (not c))))
(test "propogate bindings" new_bindings '(a))
(test "propogate leftover check-bindings" (check-bindings new_terms new_bindings) Nil))

(format t "~%")

(multiple-value-bind (new_terms new_bindings) (dpll (cdr (exp->cnf '(and a (or b (not a))))) NIL)
(test "dpll true 1" (check-bindings new_terms new_bindings) Nil))

                
(exit)