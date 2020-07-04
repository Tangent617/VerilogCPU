 .text
    addi     $t5,$t5,40             # $t5 = 20  
    li      $t2, 1                  # $t2 = 1 
    sw      $zero, 0($t0)             # store F[0] with 0
    sw      $t2, 4($t0)             # store F[1] with 1
    ori     $t6, $zero, 2           # $t6 = 2
    subu    $t1, $t5, $t6           # the number of loop is (size-2)
    ori     $t7, $zero, 1           # $t7 = 1 
    addi    $t0, $t0, 8             # point to F[3]
Loop:
    slt     $t4, $t1, $t7           # $t4 = ($t1 < 1) ? 1 : 0
    beq	    $t4, $t7, Loop_End      # repeat if not finished yet
    lw      $a0, -8($t0)            # $a0 = F[n-2]
    lw      $a1, -4($t0)            # $a1 = F[n-1]
    jal     fibonacci               # $v0 = fibonacci( F[n-2], F[n-1] )
    sw      $v0, 0($t0)             # store F[n]
    addi    $t0, $t0, 4             # $t0 point to element
    addi    $t1, $t1, -1            # loop counter decreased by 1
	j       Loop	
Loop_End:    
    lui     $t6, 0xABCD             # $t6 = 0xABCD0000
    sw      $t6, 0($t0)             # *$t0 = $t6
Loop_Forever:
    j       Loop_Forever            # loop forever
fibonacci :
    addu    $v0, $a0, $a1	# $v0 = x + y
    jr      $ra             # return
