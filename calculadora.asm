.data
v_sueldo: .double 410.00

sueldo1: .double 410.00
sueldo2: .double 512.50
sueldo3: .double 1230.00
sueldo4: .double 1640.00
sueldo5: .double 2665.00
sueldo6: .double 3690.00

#Valores de porcentaje respecto a valores ingresados de sueldo y cantidad de hijos
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
	li $v0, 7
	la $a0, texto
	li $a1, len
	syscall
	la $a0, newLine 
	
	l.d $f2, v_sueldo 
	c.lt.d $f2, $f0  #validacion de si el sueldo ingresado es mayor al SBU
	bc1f ErrorSueldo   #si el sgt bota 0, se presenta la funcion de error
	
	#ingreso de numero de hijos
	li $v0, 4
	la $a0, hijos
	syscall
	li $v0, 5
	la $a0, texto
	li $a1, len
	syscall
	la $a0, newLine
	
	move $s1, $v0   #moviendo el valor de hijos ingresado
	sgt $t1, $s1, 0  #validacion de si la cantidad de hijos es mayor a 0
	beq $t1, $zero, ErrorHijos
	
	jal condiciones
	mov.d $f12, $f12
	
	#presentación de resultado final
	li $v0, 4
	la $a0, resultado
	syscall
	li $v0, 3
	mov.d $f12, $f0
	syscall
	li $v0, 4
	la $a0, newLine
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
	addi $sp, $sp, -4
	sw $ra, ($sp)
	
	#movimiento y conversión de datos a flotantes
	mtc1.d $s1, $f2
	cvt.d.w $f2, $f2 #VALOR HIJOS
	
	l.d $f10, sueldo1
	l.d $f22, sueldo2
	l.d $f14, sueldo3
	l.d $f16, sueldo4
	l.d $f18, sueldo5
	l.d $f20, sueldo6
	
	c.lt.d $f20, $f0
	bc1t sueldo_3690 #si el sueldo es mayor a 3690
	
	c.lt.d $f18, $f0
	bc1t sueldo_2665 #si el sueldo es mayor a 2665
	
	c.lt.d $f16, $f0
	bc1t sueldo_1640 #si el sueldo es mayor a 1640
	
	c.lt.d $f14, $f0
	bc1t sueldo_1230 #si el sueldo es mayor a 1230
	
	c.lt.d $f22, $f0
	bc1t sueldo_512   #si el sueldo es mayor a 512
	
	c.lt.d $f10, $f0
	bc1t sueldo_410   #si el sueldo es mayor a 410
	
	sueldo_3690:
		l.d $f6, porcentaje6
		mul.d $f8, $f6, $f0
		mov.d $f0, $f8
		
		lw $ra, ($sp)
		addi $sp, $sp, 4 
		jr $ra

	sueldo_2665:
		l.d $f6, porcentaje5
		mul.d $f8, $f6, $f0
		mov.d $f0, $f8
		
		lw $ra, ($sp)
		addi $sp, $sp, 4 
		jr $ra

	sueldo_1640:
		l.d $f6, porcentaje4
		mul.d $f8, $f6, $f0
		mov.d $f0, $f8
		
		lw $ra, ($sp)
		addi $sp, $sp, 4 
		jr $ra

	sueldo_1230:
		l.d $f6, porcentaje3
		mul.d $f8, $f6, $f0
		mov.d $f0, $f8
		
		lw $ra, ($sp)
		addi $sp, $sp, 4 
		jr $ra

	sueldo_512:
		beq $s1, 1, hijos2_512
		bge $s1, 2, hijos1_512

		hijos1_512:
			l.d $f6, porcentaje2_1
			mul.d $f8, $f6, $f0
			mov.d $f0, $f8
			
			lw $ra, ($sp)
			addi $sp, $sp, 4 
			jr $ra
			
		hijos2_512: 
			l.d $f6, porcentaje2_2
			mul.d $f8, $f6, $f0
			mov.d $f0, $f8
			
			lw $ra, ($sp)
			addi $sp, $sp, 4 
			jr $ra
		
	sueldo_410:
		beq $s1, 1, hijos3_410
		beq $s1, 2, hijos2_410
		bge $s1, 3, hijos1_410

		hijos1_410:
			l.d $f6, porcentaje1_1
			mul.d $f8, $f6, $f0
			mov.d $f0, $f8
			
			lw $ra, ($sp)
			addi $sp, $sp, 4 
			jr $ra
			
		hijos2_410: 
			l.d $f6, porcentaje1_2
			mul.d $f8, $f6, $f0
			mov.d $f0, $f8
			
			lw $ra, ($sp)
			addi $sp, $sp, 4 
			jr $ra
			
   		hijos3_410:
   			l.d $f6, porcentaje1_3
   			mul.d $f8, $f6, $f0
   			mov.d $f0, $f8
   			 	
			lw $ra, ($sp)
			addi $sp, $sp, 4 
			jr $ra

fin: 
	li $v0, 4
	la $a0, printFinal
	syscall
	la $a0, newLine
	syscall
	li $v0, 10
	syscall
