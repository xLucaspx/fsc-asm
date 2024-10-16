# ------------------------------------------------------------ #
# FUNDAMENTOS DE SISTEMAS COMPUTACIONAIS - SYSTEMCALL - RISC-V #
#              Prof. Iacana Ianiski Weber - PUCRS              #
# ------------------------------------------------------------ #
# Exercicio 3 --------------------------------------------------
# Contar a quantidade de caracteres de uma string.
#
# int contaCaracteres(char str[]) {
# 	int i = 0;
# 	while (str[i] != '\0') i++;
# 	return i;
# }
#
# int main() {
# 	char txt[100];
# 	printf("Digite uma string: ");
# 	fgets(txt, 100, stdin);
# 	return 0;
# }
#
# --------------------------------------------------------------
.data # Dados do programa
read_s:   .string "Digite uma string: "
ln:       .string "\n"
str_res1: .string "A string tem "
str_res2: .string " caracteres."
str:      .string
# --------------------------------------------------------------
.text # Codigo
.globl main
main:
	li a7 4             # a7 = 4 (print string)
	la a0 read_s        # a0 = &read_s
	ecall

	li a7 8             # a7 = 8 (read string)
	la a0 str           # a0 = &str
	li a1 100           # a1 = 100 (max size)
	ecall               # read str

	jal ra print_length # a0 = length(&str)
	mv s0 a0            # s0 = a0

	li a7 4             # a7 = 4 (print string)
	la a0 str_res1      # a0 = &str_res1
	ecall               # print a0

	li a7 1             # a7 = 1 (print int)
	mv a0 s0            # a0 = length(&str)
	ecall               # print a0

	li a7 4             # a7 = 4 (print string)
	la a0 str_res2      # a0 = &str_res2
	ecall               # print a0
	la a0 ln            # a0 = &ln
	ecall               # print(ln)

	j fim               # exit

print_length:         # void length(char* a0)
	xor t0 t0 t0        # i = 0
	li t2 '\n'          # t2 = '\n'
	loop:
		add t1 a0 t0      # t1 = &a0[i]
		lb t1 0(t1)       # t1 = a0[i]

		beq t1 t2 endf    # if (t1 == '\n') goto endf
		addi t0 t0 1      # i++
		j loop            # goto loop

	endf:
		mv a0 t0          # a0 = i
		jr ra             # return i

fim:
	li a7 93            # a7 = 93 (exit code)
	xor a0 a0 a0        # a0 = 0 (exit status)
	ecall               # exits
