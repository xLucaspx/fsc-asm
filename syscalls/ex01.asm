# ------------------------------------------------------------ #
# FUNDAMENTOS DE SISTEMAS COMPUTACIONAIS - SYSTEMCALL - RISC-V #
#              Prof. Iacana Ianiski Weber - PUCRS              #
# ------------------------------------------------------------ #
# Exercicio 1 --------------------------------------------------
# Verificar a paridade de um número:
#
# void verificaParidade(int n) {
# 	if (n % 2 == 0) printf("%d é par.\n", n);
# 	else printf("%d é ímpar.\n", n);
# }
#
# int main() {
# 	int x;
# 	printf("Digite um número: ");
# 	scanf("%d", &x);
# 	verificaParidade(x);
# 	return 0;
# }
#
# --------------------------------------------------------------
.data # Dados do programa
read_n:   .string "Digite um número: "
ln:       .string "\n"
str_odd:  .string " é ímpar."
str_even: .string " é par."
# --------------------------------------------------------------
.text # Codigo
.globl main
main:
	li a7 4             # a7 = 4 (print string)
	la a0 read_n        # a0 = &read_n
	ecall

	li a7 5             # a7 = 5 (read int)
	ecall               # a0 = n

	jal ra print_parity # printParity(n)
	j fim               # exit

print_parity:         # void printParity(int a0)
	andi t0 a0 0x1      # t0 = a0 & 1
	li t1 1             # t1 = 1

	li a7 1             # a7 = 1 (print int)
	ecall               # print(a0)

	beq t0 t1 odd       # if (t0 == 1) goto odd
	la a0 str_even      # a0 = &str_even
	j endf              # goto endf
	odd:
		la a0 str_odd     # a0 = &str_odd
	endf:
		li a7 4           # a7 = 4 (print string)
		ecall             # print a0
		la a0 ln          # a0 = &ln
		ecall             # print(ln)
		jr ra

fim:
	li a7 93            # a7 = 93 (exit code)
	xor a0 a0 a0        # a0 = 0 (exit status)
	ecall               # exits
