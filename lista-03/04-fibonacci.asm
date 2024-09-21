# --------------------------------------------------------- #
# FUNDAMENTOS DE SISTEMAS COMPUTACIONAIS - LISTA 3 - RISC-V #
#             Prof. Iacana Ianiski Weber - PUCRS            #
# --------------------------------------------------------- #
# Exercicio 4 -----------------------------------------------
# Implemente um código que calcula o enésimo valor da
# série Fibonacci; utilize uma funcao recursiva para tal.
# Não esqueça de fazer a manipulação da pilha.
#
# int fibonacci(int n) {
# 	if (n <= 1) return n; // Caso base: fibonacci(0) = 0 e fibonacci(1) = 1
# 	return fibonacci(n - 1) + fibonacci(n - 2); // Chamada recursiva
# }
# -----------------------------------------------------------
.data               # Dados do programa
n: .word 20         # fibonacci(20) = 6765
# -----------------------------------------------------------
.text               # Codigo
.globl main
main:
	la s0 n           # s0 = &n
	lw a0 0(s0)       # a0 = n

	jal ra fibonacci  # call fibonacci(a0)
	mv s1 a0          # s1 = fibonacci(n)

	sw s1 0(s0)       # mem[&n] = fibonacci(n)
	j fim

fibonacci:          # int fibonacci(int a0)
	addi sp sp -12    # vamos usar a pilha para salvar ra, s0 e s1
	sw ra 0(sp)       # salvando ra na pilha
	sw s0 4(sp)       # salvando s0 na pilha
	sw s1 8(sp)       # salvando s1 na pilha

	li t0 1           # int comp = 1
	bge t0 a0 f_end   # if (1 >= n) return n; (a0 ainda tem o valor de n)

	addi s0 a0 -1     # s0 = n - 1

	mv a0 s0          # a0 = a0 - 1
	jal ra fibonacci  # a0 = fibonacci(n - 1)
	mv s1 a0          # s1 = fibonacci(n - 1)

	addi a0 s0 -1     # a0 = n - 2
	jal ra fibonacci  # a0 = fibonacci(n - 2)

	add a0 a0 s1      # a0 = fibonacci(n - 1) + fibonacci(n - 2)

f_end:
	lw ra 0(sp)       # recuperando ra da pilha
	lw s0 4(sp)       # recuperando s0 da pilha
	lw s1 8(sp)       # recuperando s1 da pilha
	addi sp sp 12     # restaurando a pilha
	jr ra             # retornando para a chamada da função

fim:
	j fim
