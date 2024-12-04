(define (problem ThreePeg-TwoDisk)
    (:domain hanoi)
  (:objects p1 p2 p3 d1 d2 d3 d4)
  (:goal (and (onpeg d4 p3)(ontable d4)(on d1 d2)(on d2 d3)(on d3 d4)))
  (:init (onpeg d1 p1)
  		 (onpeg d2 p1)
  		 (onpeg d3 p1)
  		 (onpeg d4 p1)
  		 (on d1 d2)
  		 (on d2 d3)
  		 (on d3 d4)
  		 (ontable d4)
		 (clear d1)
		 (handempty)
  		 (isdisk d1)
  		 (isdisk d2)
  		 (isdisk d3)
  		 (isdisk d4)
  		 (issmaller d1 d2)
  		 (issmaller d1 d3)
  		 (issmaller d1 d4)
  		 (issmaller d2 d3)
  		 (issmaller d2 d4)
  		 (issmaller d3 d4)
  		 (ispeg p1)
  		 (ispeg p2)
  		 (ispeg p3)
  		 (pegclear p2)
  		 (pegclear p3)))