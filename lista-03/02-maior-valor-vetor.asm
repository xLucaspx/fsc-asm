# --------------------------------------------------------- #
# FUNDAMENTOS DE SISTEMAS COMPUTACIONAIS - LISTA 3 - RISC-V #
#             Prof. Iacana Ianiski Weber - PUCRS            #
# --------------------------------------------------------- #
# Exercicio 2 -----------------------------------------------
# Implementar o código que segue para calcular o maior valor
# em um vetor de naturais, utilizando o assembly do MIPSs
# (usar apenas o subconjunto de instruções apresentado em aula)
#
# main() {
# 	int a[] = { 0x123, 0x345, 0x879, 0x100, 0x090 };
# 	int max = 0, n = 5;
# 	for(int i = 0; i < n; i++)  {
# 		if (a[i] > max) max = a[i];
#		}
# }
# -----------------------------------------------------------
.data # Dados do programa
max: .word 0
n:   .word 5
a:   .word 0x123 0x345 0x879 0x100 0x090
# -----------------------------------------------------------
.text # Codigo
.globl main
main:
	la s0 n               # s0 = &n
	lw s0 0(s0)           # s0 (size) = n

	la s1 a               # s1 = &a

	li s2 0               # s2 (max) = 0
	li t0 0               # t0 (i) = 0

loop:
	bge t0 s0 endl        # if (i >= size) break

	slli t1 t0 2          # t1 = i * 4 (deslocamento para acessar elementos de a[])
	add t1 t1 s1          # t1 = &a[i]
	lw t1 0(t1)           # t1 = a[i]

	bge s2 t1 increment   # if (max >= a[i]) continue
	mv s2 t1              # s2 (max) = a[i]

increment:
	addi t0 t0 1          # i++
	j loop

endl:
	la t0 max             # t0 = &max
	sw s2 0(t0)           # mem[&max] = max

	li a7 93              # a7 = 93 (exit code)
	xor a0 a0 a0          # a0 = 0 (exit status)
	ecall                 # exits
