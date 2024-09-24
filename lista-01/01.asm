# ---------------------------------------------- #
# FUNDAMENTOS DE SISTEMAS COMPUTACIONAIS - PUCRS #
#          ASSEMBLY DO RISC-V - LISTA I          #
# ---------------------------------------------- #
# Exercicio 1 ------------------------------------
# Traduizr o seguinte código para assembly RISC-V:
#
# int a = 5;
# int b = 10;
# int c = a + b;
# ------------------------------------------------
.data # Dados do programa
a: .word  5
b: .word 10
c: .word  0
# ------------------------------------------------
.text # Codigo
.globl main
main:
	la t0 a        # t0 = &a
	lw t0 0(t0)    # t0 = a

	la t1 b        # t1 = &b
	lw t1 0(t1)    # t1 = b

	add s0 t0 t1   # s0 = a + b

	la t3 c        # t3 = &c
	sw s0 0(t3)    # mem[&c] = s0 (a + b)

fim:
	j fim # trava o processador
