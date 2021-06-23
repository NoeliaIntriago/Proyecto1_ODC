.data
sueldo1: .double 410.00
sueldo2: .double 512.50
sueldo3: .double 1230.00
sueldo4: .double 1640.00
sueldo5: .double 2665.00
sueldo6: .double 3690.00
.text
.globl condiciones

addi $sp, $sp, -12
sw $ra, ($sp)
sw $a1, 4($sp)
sw $a2, 8($sp)

bgt $s0, sueldo6, sueldo_3690
bgt $s0, sueldo5, sueldo_2665
bgt $s0, sueldo4, sueldo_1640
bgt $s0, sueldo3, sueldo_1230
bgt $s0, sueldo2, sueldo_512
bgt $s0, sueldo1, sueldo_410

sueldo_3690:
	l.d $f12, sueldo6
	mtc1 $s0,$f0
	cvt.d.w $f0,$f0
	mul.d $t0, $f12, $f0
	mul.d $t0, $t0, 0.4253
	move $v0, $t0

sueldo_2665:
	l.d $f12, sueldo6
	mtc1 $s0,$f0
	cvt.d.w $f0,$f0
	mul.d $t0, $f12, $f0
	mul.d $t0, $t0, 0.4253
	move $v0, $t0

sueldo_1640:
	l.d $f12, sueldo6
	mtc1 $s0,$f0
	cvt.d.w $f0,$f0
	mul.d $t0, $f12, $f0
	mul.d $t0, $t0, 0.4253
	move $v0, $t0

sueldo_1230:
	l.d $f12, sueldo6
	mtc1 $s0,$f0
	cvt.d.w $f0,$f0
	mul.d $t0, $f12, $f0
	mul.d $t0, $t0, 0.4253
	move $v0, $t0

sueldo_512:


sueldo_410:
   	
   	
lw $a2, 8($sp)
lw $a1, 4($sp)   	
lw $ra, ($sp)
addi $sp, $sp, 12

jr $ra