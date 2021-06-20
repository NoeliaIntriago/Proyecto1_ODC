.data
.eqv len 10

#Strings a usar en el proyecto
presentacion: .asciiz "------Bienvenido al sistema de consulta 'PENSIONES ALIMENTICIAS'------"
sueldo: .asciiz "Ingrese su sueldo actual: $"
hijos: .asciiz "Ingrese la cantidad de hijos: "
errorDelSueldo: .asciiz "Error, el sueldo ingresado no es mayor al SBU. Ingrese uno mayor"
errorDeHijos: .asciiz "Error, el numero de hijos tiene que ser mayor a 0"
printFinal: .asciiz "Gracias por usar nuestro servicio. Hasta pronto :)"
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
fin: 
	li $v0, 4
	la $a0, printFinal
	syscall
	la $a0, newLine
	syscall
	li $v0, 10
	syscall
