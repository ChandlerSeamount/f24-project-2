(define (problem TwoPeg-OneDisk)
    (:domain hanoi)
  (:objects p1 p2 d1)
  (:goal (and (onpeg d1 p2)(ontable d1)))
  (:init (onpeg d1 p1)
  		 (ontable d1)
		 (clear d1)
		 (handempty)
  		 (isdisk d1)
  		 (ispeg p1)
  		 (ispeg p2)
  		 (pegclear p2)))