# --------------------------------------------------------- #
# FUNDAMENTOS DE SISTEMAS COMPUTACIONAIS - LISTA 3 - RISC-V #
#             Prof. Iacana Ianiski Weber - PUCRS            #
# --------------------------------------------------------- #
# Exercicio 3 -----------------------------------------------
# Implementar o código que segue para calcular divisão
# por subtrações sucessivas, utilizando o assembly do MIPS
# (usar apenas o subconjunto de instruções apresentado em aula)
#
# Exemplo de divisão de 10 por 3 usando subtrações sucessivas:
# | Dividendo | Divisor |  Dividendo - Divisor | Quociente |
# | --------- | ------- | -------------------- | --------- |
# |    10     |    3    |           7          |     1     |
# |     7     |    3    |           4          |     2     |
# |     4     |    3    |           1          |     3     |
# |    d1     |   d2    |         resto        |     q     |
#
# int main() {
# 	int dividendo = 10, divisor = 3, quociente = 0;
# 	while (dividendo >= divisor) {
# 		dividendo -= divisor;
# 		quociente++;
# 	}
# 	int resto = dividendo;
# }
# -----------------------------------------------------------
.data # Dados do programa
d1:    .word 0xFAAA  # 64170  resposta: 489 (1E9)  resto 111  (6F)
d2:    .word 0x83    # 131
q:     .word 0
resto: .word 0
# -----------------------------------------------------------
.text # Codigo
.globl main
main:
	la s0 d1         # s0 = &dividendo (d1)
	lw s0 0(s0)      # s0 = d1

	la s1 d2         # s1 = &divisor (d2)
	lw s1 0(s1)      # s1 = d2

	li s2 0          # quociente (q) = 0

loop:
	blt s0 s1 endl   # if (dividendo < divisor) break

	sub s0 s0 s1     # d1 -= d2
	addi s2 s2 1     # q++
	j loop

endl:
	la t0 q          # t0 = &q
	sw s2 0(t0)      # mem[&q] = q

	la t0 resto      # t0 = &resto
	sw s0 0(t0)      # mem[&resto] = d1

	li a7 93         # a7 = 93 (exit code)
	xor a0 a0 a0     # a0 = 0 (exit status)
	ecall            # exits
