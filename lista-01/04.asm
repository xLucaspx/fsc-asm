# ---------------------------------------------- #
# FUNDAMENTOS DE SISTEMAS COMPUTACIONAIS - PUCRS #
#          ASSEMBLY DO RISC-V - LISTA I          #
# ---------------------------------------------- #
# Exercicio 4 ------------------------------------
# Traduizr o seguinte código para assembly RISC-V:
#
# char x = 'A';
# char y = 'Z';
# char z = x + y;
# ------------------------------------------------
.data # Dados do programa
x: .byte 'A' # 65
y: .byte 'Z' # 90
z: .byte 0   # x + y -> signed char: -101 (?), unsigned char: 155
# ------------------------------------------------
.text # Codigo
.globl main
main:
	la t0 x        # t0 = &x
	lb t0 0(t0)    # t0 = x (lb -> load byte , i.e. 8 bits)

	la t1 y        # t1 = &y
	lb t1 0(t1)    # t1 = y

	add t0 t0 t1   # t0 += t1 (x + y)

	la t1 z        # t1 = &z
	sb t0 0(t1)    # mem[&z] = t0 (x + y)
                 # sb -> store byte, i.e. 8 bits
fim:
	j fim # trava o processador
