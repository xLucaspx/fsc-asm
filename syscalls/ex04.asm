# ------------------------------------------------------------ #
# FUNDAMENTOS DE SISTEMAS COMPUTACIONAIS - SYSTEMCALL - RISC-V #
#              Prof. Iacana Ianiski Weber - PUCRS              #
# ------------------------------------------------------------ #
# Exercicio 4 --------------------------------------------------
# Comparar dois números:
#
# void comparar(int a, int b) {
# 	if (a > b) printf("%d é maior que %d\n", a, b);
# 	else if (a < b) printf("%d é menor que %d\n", a, b);
# 	else printf("%d é igual a %d\n", a, b);
# }
#
# int main() {
# 	int x, y;
# 	printf("Digite o primeiro número: ");
# 	scanf("%d%, &x);
# 	printf("Digite o segundo número: ");
# 	scanf("%d%, &y);
# 	comparar(x, y);
# 	return 0;
# }
#
# --------------------------------------------------------------
.data # Dados do programa
read_x: .string "Digite o primeiro número: "
read_y: .string "Digite o segundo número: "
str_gt: .string " é maior que "
str_lt: .string " é menor que "
str_eq: .string " é igual a "
ln:     .string "\n"
# --------------------------------------------------------------
.text # Codigo
.globl main
main:
	li a7 4           # a7 = 4 (print string)
	la a0 read_x      # a0 = &read_x
	ecall             # print a0

	li a7 5           # a7 = 5 (read int)
	ecall             # a0 = x
	mv s0 a0          # s0 = x

	li a7 4           # a7 = 4 (print string)
	la a0 read_y      # a0 = &read_y
	ecall             # print a0

	li a7 5           # a7 = 5 (read int)
	ecall             # a0 = y

	mv a1 a0          # a1 = y
	mv a0 s0          # a0 = x
	jal ra compare    # compare(a0, a1)
	j fim             # exit

compare:            # void compare(int a0, int a1)
	li a7 1           # a7 = 1 (print int)
	ecall             # print a0

	bgt a0 a1 greater # if (a0 > a1) goto greater
	blt a0 a1 lesser  # else if (a0 < a1) goto lesser
	la a0 str_eq      # else a0 = &str_eq
	j endf            # goto endf
	greater:
		la a0 str_gt    # a0 = &str_gt
		j endf          # goto endf
	lesser:
		la a0 str_lt    # a0 = &str_lt

	endf:
		li a7 4         # a7 = 4 (print string)
		ecall           # print a0

		li a7 1         # a7 = 1 (print int)
		mv a0 a1        # a0 = a1
		ecall           # print a1

		li a7 4         # a7 = 4 (print string)
		la a0 ln        # a0 = &ln
		ecall           # print ln
		jr ra           # return

fim:
	li a7 93          # a7 = 93 (exit code)
	xor a0 a0 a0      # a0 = 0 (exit status)
	ecall             # exits
