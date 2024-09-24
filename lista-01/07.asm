# ---------------------------------------------- #
# FUNDAMENTOS DE SISTEMAS COMPUTACIONAIS - PUCRS #
#          ASSEMBLY DO RISC-V - LISTA I          #
# ---------------------------------------------- #
# Exercicio 7 ------------------------------------
# Traduizr o seguinte código para assembly RISC-V:
#
# int x = 7;
# int y = 21;
# int z = x - 3 + y;
# ------------------------------------------------
.data # Dados do programa
x: .word  7
y: .word 21
z: .word  0
# ------------------------------------------------
.text # Codigo
.globl main
main:
	la t0 x         # t0 = &x
	lw t0 0(t0)     # t0 = x

	la t1 y         # t1 = &y
	lw t1 0(t1)     # t1 = y

	addi t0 t0 -3   # t0 -= 3
	add t0 t0 t1    # t0 += t1

	la t1 z         # t1 = &z
	sw t0 0(t1)     # mem[&z] = t0

fim:
	j fim # trava o processador
