# --------------------------------------------------------- #
# FUNDAMENTOS DE SISTEMAS COMPUTACIONAIS - LISTA 3 - RISC-V #
#             Prof. Iacana Ianiski Weber - PUCRS            #
# --------------------------------------------------------- #
# Exercicio 5 -----------------------------------------------
# Implemente um código para ordenar um vetor, utilizando o assembly do RISC-V
#
# int main(){
# 	int N = 10;
# 	int vet[10] = { 0x323, 0x223, 0x123, 0x90, 0x90, 0x45, 0x43, 0x34, 0xAAA, 0x775 };
# 	int i, j, swap;
# 	for (i = 0; i < N - 1; i++) {
# 		for (j = 0; j < N - 1 - i; j++) {
# 			if (vet[j] > vet[j+1]) { // For decreasing order use '<' instead of '>’
# 				swap     = vet[j];
# 				vet[j]   = vet[j+1];
# 				vet[j+1] = swap;
# 			}
# 		}
# 	}
# 	return 0;
# }
# -----------------------------------------------------------
.data # Dados do programa
N:   .word 10
vet: .word 0x323 0x223 0x123 0x90 0x90 0x45 0x43 0x34 0xAAA 0x775
# -----------------------------------------------------------
.text # Codigo
.globl main
main:
	# TODO <COMPLETAR>
fim:
	li a7 93       # a7 = 93 (exit code)
	xor a0 a0 a0   # a0 = 0 (exit status)
	ecall          # exits
