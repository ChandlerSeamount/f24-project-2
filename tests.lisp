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


(exit)