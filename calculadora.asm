.data
sueldo: .asciiz "Ingrese su sueldo actual: $"
hijos: .asciiz "Ingrese la cantidad de hijos: "
newLine: .asciiz "\n"

.text
.globl main

main:


fin: 
	li $v0, 10
	syscall
