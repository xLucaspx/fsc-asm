# ---------------------------------------------- #
# FUNDAMENTOS DE SISTEMAS COMPUTACIONAIS - PUCRS #
#          ASSEMBLY DO RISC-V - LISTA I          #
# ---------------------------------------------- #
# Exercicio 3 ------------------------------------
# Traduizr o seguinte código para assembly RISC-V:
#
# int a = 8;
# int b = 6;
# int c = a * 2 + b;
# ------------------------------------------------
.data # Dados do programa
a: .word 8
b: .word 6
c: .word 0
# ------------------------------------------------
.text # Codigo
.globl main
main:
	la t0 a        # t0 = &a
	lw t0 0(t0)    # t0 = a

	la t1 b        # t1 = &b
	lw t1 0(t1)    # t1 = b

	slli t0 t0 1   # t0 *= 2 (t0 = t0 * 2^1, shift left n vezes = multiplicar por 2^n)
	add s0 t0 t1   # s0 = t0 + t1 (a * 2 + b)

	la t2 c        # t2 = &c
	sw s0 0(t2)    # mem[&c] = s0

	li a7 93       # a7 = 93 (exit code)
	xor a0 a0 a0   # a0 = 0 (exit status)
	ecall          # exits
