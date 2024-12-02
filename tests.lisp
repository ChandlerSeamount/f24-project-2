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



(exit)