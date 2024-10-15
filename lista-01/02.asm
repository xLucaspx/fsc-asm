# ---------------------------------------------- #
# FUNDAMENTOS DE SISTEMAS COMPUTACIONAIS - PUCRS #
#          ASSEMBLY DO RISC-V - LISTA I          #
# ---------------------------------------------- #
# Exercicio 2 ------------------------------------
# Traduizr o seguinte código para assembly RISC-V:
#
# int a = 25;
# int b = 15;
# int c = a - b - 7;
# ------------------------------------------------
.data # Dados do programa
a: .word 25
b: .word 15
c: .word  0
# ------------------------------------------------
.text # Codigo
.globl main
main:
	la t0 a         # t0 = &a
	lw t0 0(t0)     # t0 = a

	la t1 b         # t1 = &b
	lw t1 0(t1)     # t1 = b

	sub s0 t0 t1    # s0 = a - b
	addi s0 s0 -7   # s0 -= 7 (s0 = s0 + (-7))

	la t2 c         # t2 = &c
	sw s0 0(t2)     # mem[&c] = s0

	li a7 93        # a7 = 93 (exit code)
	xor a0 a0 a0    # a0 = 0 (exit status)
	ecall           # exits
