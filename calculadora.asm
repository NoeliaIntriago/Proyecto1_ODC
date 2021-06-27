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
.eqv len 10

#Strings a usar en el proyecto
presentacion: .asciiz "------Bienvenido al sistema de consulta 'PENSIONES ALIMENTICIAS'------"
sueldo: .asciiz "Ingrese su sueldo actual: $"
hijos: .asciiz "Ingrese la cantidad de hijos: "
errorDelSueldo: .asciiz "Error, el sueldo ingresado no es mayor al SBU. Ingrese uno mayor"
errorDeHijos: .asciiz "Error, el numero de hijos tiene que ser mayor a 0"
printFinal: .asciiz "Gracias por usar nuestro servicio. Hasta pronto :)"
resultado: .asciiz "La pensión alimenticia a pagar es: $"
newLine: .asciiz "\n"
texto: .space len

.text
.globl launch

launch:
	li $v0, 4
	la $a0, presentacion
	syscall
	la $a0, newLine
	syscall
	
	j main

main:
	li $v0, 4
	la $a0, sueldo
	syscall
	li $v0,5
	la $a0, texto
	li $a1, len
	syscall
	la $a0, newLine 
	
	move $s0, $v0   #moviendo el valor de sueldo ingresado
	sgt $t1, $s0, 410  #validacion de si el sueldo ingresado es mayor al SBU
	beq $t1, $zero, ErrorSueldo   #si el sgt bota 0, se presenta la funcion de error
	
	#ingreso de numero de hijos
	li $v0, 4
	la $a0, hijos
	syscall
	li $v0,5
	la $a0, texto
	li $a1, len
	syscall
	la $a0, newLine
	
	move $s1, $v0   #moviendo el valor de hijos ingresado
	sgt $t1, $s1, 0  #validacion de si el sueldo ingresado es mayor al SBU
	beq $t1, $zero, ErrorSueldo
	
	move $a1, $s0
	move $a2, $s1
	jal condiciones
	move $s2, $v0
	
	li $v0, 4
	la $a0, resultado
	li $v0, 1
	la $a0, ($s2)
	syscall
	
	j fin

ErrorSueldo:
	li $v0, 4
	la $a0, errorDelSueldo
	syscall
	la $a0, newLine
	syscall
	
	j main

ErrorHijos:
	li $v0, 4
	la $a0, errorDeHijos
	syscall
	la $a0, newLine
	syscall
	
	j main
	
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


fin: 
	li $v0, 4
	la $a0, printFinal
	syscall
	la $a0, newLine
	syscall
	li $v0, 10
	syscall
