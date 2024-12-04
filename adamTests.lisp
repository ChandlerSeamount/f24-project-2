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

(test "(c xor a) implies not b -> nnf" (exp->nnf '(:implies (:xor c a) (not b))) '(or (or (and (not c) (not a)) (and c a)) (not b)))
(test "(c xor a) implies not b -> cnf" (exp->cnf '(:implies (:xor c a) (not b))) '(or (or (and (not c) (not a)) (and c a)) (not b)))

(format t "~%")
(test "sort-lits with not" (sort-lits '(a (not b))) '(a (not b)))

(test "dist 1" (nnf->cnf '(or a (and b c))) '(and (or a b) (or a c)))
(test "dist 2" (nnf->cnf '(or x (and a b c))) '(and (or a x) (or b x) (or c x)))
(test "dist 3" (nnf->cnf '(or (or x y) (and b c))) '(and (or b x y) (or c x y)))
(test "dist 4" (nnf->cnf '(or (or x y z) (and b c))) '(and (or b x y z) (or c x y z)))

(format t "~%")

(test "dist 5" (nnf->cnf '(or (and x y) (and b c))) '(and (or b x) (or b y) (or c x) (or c y)))
(test "dist 6" (nnf->cnf '(or (and x y z) (and a b c))) '(and (or a x) (or a y) (or a z) (or b x) (or b y) (or b z) (or c x) (or c y) (or c z)))

(format t "~%")

(multiple-value-bind (new_terms new_bindings) (dpll-unit-propagate (cdr (exp->cnf '(and a (or b (not a))))) NIL)
(test "nil leftover term" new_terms nil)
(test "propagation bindings" new_bindings '(b a)) 
(test "propogate true 1" (check-bindings new_terms new_bindings) T))

(multiple-value-bind (new_terms new_bindings) (dpll-unit-propagate (cdr (exp->cnf '(and a (and b (not a))))) NIL)
(test "propogate false 1" (check-bindings new_terms new_bindings) Nil))

(multiple-value-bind (new_terms new_bindings) (dpll-unit-propagate (cdr (exp->cnf '(and a (or b (not c))))) NIL)
(test "propogate leftover terms" new_terms '((or b (not c))))
(test "propogate bindings" new_bindings '(a))
(test "propogate leftover check-bindings" (check-bindings new_terms new_bindings) Nil))

(format t "~%")

(multiple-value-bind (is_sat new_bindings) (dpll (cdr (exp->cnf '(and a (or b (not a))))) NIL)
(test "dpll is_sat true" is_sat T)
(test "dpll bindings" new_bindings '(b a))
(test "dpll true 1" (check-bindings (cdr (exp->cnf '(and a (or b (not a))))) new_bindings) T))

(format t "~%")

(multiple-value-bind (is_sat new_bindings) (sat-p '(and a (or b (not a))))
(test "sat true 1" is_sat T)
(test "sat true 1 bindings" new_bindings '(b a)))

(multiple-value-bind (is_sat new_bindings) (sat-p '(and a (and b (not a))))
(test "sat false 1" is_sat Nil)
(test "sat false 1 bindings" new_bindings Nil))

(multiple-value-bind (is_sat new_bindings) (sat-p '(and a (or b c)))
(test "sat true 2" is_sat T)
(test "sat true 2 bindings" new_bindings '(b a)))

(multiple-value-bind (is_sat new_bindings) (sat-p '(and a (and b c)))
(test "sat true 3" is_sat T)
(test "sat true 3 bindings" new_bindings '(a b c)))

(multiple-value-bind (is_sat new_bindings) (sat-p '(and a (or (not b) (not c))))
(test "sat true 4" is_sat T)
(test "sat true 4 bindings" new_bindings '((not c) b a)))

(multiple-value-bind (is_sat new_bindings) (sat-p '(and (not a) (:iff b c)))
(test "sat-0" is_sat T)
(test "sat-0 bindings" new_bindings '(b c (not a))))

(multiple-value-bind (is_sat new_bindings) (sat-p '(and (not c) (or a a b) (not c)))
(test "sat-1a" is_sat T)
(test "sat-1a bindings" new_bindings '(a (not c))))

(multiple-value-bind (is_sat new_bindings) (sat-p '(and (not c) (or a a b) c))
(test "sat-1b" is_sat Nil)
(test "sat-1b bindings" new_bindings Nil))

(multiple-value-bind (is_sat new_bindings) (sat-p '(:implies (:xor c a) (not b)))
(test "sat-2" is_sat T)
(test "sat-2 bindings" new_bindings '(b c (not a))))


(exit)