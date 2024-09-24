# ---------------------------------------------- #
# FUNDAMENTOS DE SISTEMAS COMPUTACIONAIS - PUCRS #
#          ASSEMBLY DO RISC-V - LISTA I          #
# ---------------------------------------------- #
# Exercicio 6 ------------------------------------
# Traduizr o seguinte código para assembly RISC-V:
#
# int a = 5;
# int b = 10;
# int temp = a
# a = b;
# b = temp;
# ------------------------------------------------
.data # Dados do programa
a: .word  5
b: .word 10
# ------------------------------------------------
.text # Codigo
.globl main
main:
	la t0 a        # t0 = &a
	la t1 b        # t1 = &b

	lw s0 0(t0)    # s0 = a
	lw s1 0(t1)    # s1 = b

	# xor s0 s0 s1   # a ^= b
	# xor s1 s1 s0   # b ^= a
	# xor s0 s0 s1   # a ^= b
	# sw s0 0(t0)    # mem[&a] = b
	# sw s1 0(t1)    # mem[&b] = a

	sw s1 0(t0)    # mem[&a] = b
	sw s0 0(t1)    # mem[&b] = a
fim:
	j fim # trava o processador
