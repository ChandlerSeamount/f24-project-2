(define (domain hanoi)
  (:predicates (on ?x ?y)
	       (ontable ?x)
	       (holding ?x)
	       (onpeg ?d ?p)
	       (ispeg ?p)
	       (pegclear ?p)
	       (handempty)
	       (clear ?x)
	       (isdisk ?d)
	       (issmaller ?x ?y))
	       
  (:action PickUp
	     :parameters (?disk ?peg)
	     :precondition (and (isdisk ?disk)
		 					(ispeg ?peg)
				 	        (clear ?disk)
				 	        (handempty)
							(onpeg ?disk ?peg)
				 	        (ontable ?disk))
	     :effect (and (not (handempty)) 
		 			  (not (clear ?disk))
		 			  (not (onpeg ?disk ?peg))
		 			  (holding ?disk)
		 			  (pegclear ?peg)
		 			  (not (ontable ?disk))))
  (:action PutDown
	     :parameters (?disk ?peg)
	     :precondition (and (holding ?disk)
				 			(ispeg ?peg)
				 			(pegclear ?peg))
	     :effect (and (clear ?disk) 
		 			  (ontable ?disk)
		 			  (onpeg ?disk ?peg)
		 			  (not (pegclear ?peg))
		 			  (handempty)
		 			  (not (holding ?disk))))
  (:action Unstack
	     :parameters (?disk1 ?disk2 ?peg)
	     :precondition (and (isdisk ?disk1)
		 					(ispeg ?peg)
				 	        (clear ?disk1)
				 	        (handempty)
							(onpeg ?disk1 ?peg)
				 			(on ?disk1 ?disk2))
	     :effect (and (clear ?disk2)
			   		  (not (clear ?disk1))
			   		  (not (on ?disk1 ?disk2))
			   		  (not (onpeg ?disk1 ?peg))
			   		  (holding ?disk1)
			   		  (not (handempty))))  
  (:action Stack
	     :parameters (?disk1 ?disk2 ?peg)
	     :precondition (and (isdisk ?disk2)
				 			(ispeg ?peg)
							(clear ?disk2)
							(holding ?disk1)
							(issmaller ?disk1 ?disk2)
							(onpeg ?disk2 ?peg))
	     :effect (and (on ?disk1 ?disk2)
			   		  (onpeg ?disk1 ?peg)
					  (clear ?disk1)
					  (not (clear ?disk2))
		 			  (handempty)
		 			  (not (holding ?disk1))))
  )





