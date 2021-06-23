.data
sueldo1: .double 410.00
sueldo2: .double 512.50
sueldo3: .double 1230.00
sueldo4: .double 1640.00
sueldo5: .double 2665.00
sueldo6: .double 3690.00

porcentaje1_1: .double 0.5218
porcentaje1_2: .double 0.3971
porcentaje1_3: .double 0.2812
porcentaje2_1: .double 0.4745
porcentaje2_2: .double 0.3484
porcentaje3: .double 0.3849
porcentaje4: .double 0.3979
porcentaje5: .double 0.4114
porcentaje6: .double 0.4253

.text
.globl condiciones

condiciones:
addi $sp, $sp, -12
sw $ra, ($sp)
sw $a1, 4($sp)
sw $a2, 8($sp)

bgt $s0, 3690, sueldo_3690
bgt $s0, 2665, sueldo_2665
bgt $s0, 1640, sueldo_1640
bgt $s0, 1230, sueldo_1230
bgt $s0, 512, sueldo_512
bgt $s0, 410, sueldo_410

sueldo_3690:
	l.d $f2, sueldo6
	l.d $f4, porcentaje6
	mtc1 $a0, $f0
	cvt.d.w $f0, $f0
	mul.d $f2, $f2, $f0
	mul.d $f2, $f2, $f4
	move $v0, $a0

sueldo_2665:
	l.d $f2, sueldo5
	l.d $f4, porcentaje5
	mtc1 $a0, $f0
	cvt.d.w $f0, $f0
	mul.d $f2, $f2, $f0
	mul.d $f2, $f2, $f4 
	move $v0, $a0

sueldo_1640:
	l.d $f2, sueldo4
	l.d $f4, porcentaje4
	mtc1 $a0, $f0
	cvt.d.w $f0, $f0
	mul.d $f2, $f2, $f0
	mul.d $f2, $f2, $f4
	move $v0, $a0

sueldo_1230:
	l.d $f2, sueldo3
	l.d $f4, porcentaje3
	mtc1 $a0, $f0
	cvt.d.w $f0, $f0
	mul.d $f2, $f2, $f0
	mul.d $f2, $f2, $f4
	move $v0, $a0

sueldo_512:
	l.d $f12, sueldo2
	mtc1 $a0, $f0
	cvt.d.w $f0, $f0
	mul.d $f2, $f2, $f0
	beq $a2, 1, hijos1_512
	bge $a2, 2, hijos2_512

	hijos1_512:
		l.d $f4, porcentaje2_1
		mul.d $f2, $f2, $f4
		move $v0, $a0
	hijos2_512: 
		l.d $f4, porcentaje2_2
		mul.d $f2, $f2, $f4
		move $v0, $a0

sueldo_410:
   	l.d $f2, sueldo1
	mtc1 $a0, $f0
	cvt.d.w $f0, $f0
	mul.d $f2, $f2, $f0
	beq $a2, 1, hijos1_410
	beq $a2, 2, hijos2_410
	bge $a2, 3, hijos3_410

	hijos1_410:
		l.d $f4, porcentaje1_1
		mul.d $f2, $f2, $f4
		move $v0, $a0
	hijos2_410: 
		l.d $f4, porcentaje1_2
		mul.d $f2, $f2, $f4
		move $v0, $a0
   	hijos3_410:
   		l.d $f4, porcentaje1_3
   		mul.d $f2, $f2, $f4
   		move $v0, $a0
   	
lw $a2, 8($sp)
lw $a1, 4($sp)   	
lw $ra, ($sp)
addi $sp, $sp, 12

jr $ra