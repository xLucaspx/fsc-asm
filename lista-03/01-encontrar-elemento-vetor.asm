# --------------------------------------------------------- #
# FUNDAMENTOS DE SISTEMAS COMPUTACIONAIS - LISTA 3 - RISC-V #
#             Prof. Iacana Ianiski Weber - PUCRS            #
# --------------------------------------------------------- #
# Exercicio 1 -----------------------------------------------
# Encontrar um elemento no vetor `save`
# Assumir: `i` em $s3, `k` em $s5, `*save` em $s6
#
# main() {
# 	int save[] = { 0x901, 0x345, 0x879, 0x100, 0x900 };
# 	int i = 0, k = 0x100, pos = 0;
# 	while(save[i] != k)
# 		i++;
# 	pos = i;
# }
# -----------------------------------------------------------
.data # Dados do programa
k: .word 0x100
pos: .word 0
save: .word 0x901 0x345 0x879 0x100 0x900
# -----------------------------------------------------------
.text # Codigo
.globl main
main:
	li s3 0             # i = 0

	la s5 k             # s5 = &k
	lw s5 0(s5)         # s5 = k (elemento buscado)

	la s6 save          # s6 = &save

loop:
	slli t0 s3 2        # t0 = i * 4 (deslocamento para acessar proxima posicao do vetor)
	add t0 t0 s6        # t0 = &save[i]
	lw t0 0(t0)         # t0 = save[i]

	beq s5 t0 savePos   # if (k == save[i]) break

	addi s3 s3 1        # i++
	j loop

savePos:
	la t0 pos           # t0 = &pos
	sw s3 0(t0)         # mem[&pos] = i (salvando a posicao na memoria)

fim:
	j fim
