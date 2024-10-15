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
	la t0 buf               # t0 = &buf
	lw t0 0(t0)             # t0 = buf

	andi s0 t0 0x000000ff   # s0 = buf[0] (first pos)
	# andi s1 t0 0xff000000   # s1 = buf[3] (last pos) ["0xff000000": operand is out of range, ver lista-02/01.asm]

	srli t0 t0 24           # shift right buf 3 casas (8 bytes * 3 posições = 24)
                          # buf[3] -> buf[0]; e.g. 6f 6c 65 48 -> 00 00 00 6f
	andi s1 t0 0xff         # s1 = buf[3] (last pos)

	la t0 first             # t0 = &first
	sb s0 0(t0)             # mem[&first] = s0

	la t0 last              # t0 = &last
	sb s1 0(t0)             # mem[&last] = s1

	li a7 93                # a7 = 93 (exit code)
	xor a0 a0 a0            # a0 = 0 (exit status)
	ecall                   # exits
