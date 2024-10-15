# ---------------------------------------------- #
# FUNDAMENTOS DE SISTEMAS COMPUTACIONAIS - PUCRS #
#          ASSEMBLY DO RISC-V - LISTA I          #
# ---------------------------------------------- #
# Exercicio 8 ------------------------------------
# Traduizr o seguinte código para assembly RISC-V:
#
# char buf[4] = { 'H', 'e', 'l', 'o' };
# char first = buf[0];
# char last = buf[3];
# ------------------------------------------------
.data # Dados do programa
buf:   .byte 'H', 'e', 'l', 'o'
first: .byte 0
last:  .byte 0
# ------------------------------------------------
.text # Codigo
.globl main
main:
	la t0 buf     # t0 = &buf
	la t1 first   # t1 = &first
	la t2 last    # t2 = &last

	lb s0 0(t0)   # s0 = buf[0]
	lb s1 3(t0)   # s1 = buf[3] (3 bytes de deslocamento)

	sb s0 0(t1)   # mem[&first] = s0
	sb s1 0(t2)   # mem[&last] = s1

	li a7 93      # a7 = 93 (exit code)
	xor a0 a0 a0  # a0 = 0 (exit status)
	ecall         # exits
