# ------------------------------------------------------------ #
# FUNDAMENTOS DE SISTEMAS COMPUTACIONAIS - SYSTEMCALL - RISC-V #
#              Prof. Iacana Ianiski Weber - PUCRS              #
# ------------------------------------------------------------ #
# Exercicio 2 --------------------------------------------------
# Calcular fatorial:
#
# int fatorial(int n) {
# 	int res = 1;
# 	for (int i = 1; i <= n; i++) res *= i;
# 	return res;
# }
#
# int main() {
# 	int num;
# 	printf("Digite um número para calcular o fatorial: ");
# 	scanf("%d%, &num);
# 	printf("O fatorial de %d é: %d\n", num, fatorial(num));
# 	return 0;
# }
#
# --------------------------------------------------------------
.data # Dados do programa
read_n:   .string "Digite um número para calcular o fatorial: "
str_res1: .string "O fatorial de "
str_res2: .string " é "
ln:       .string "\n"
# --------------------------------------------------------------
.text # Codigo
.globl main
main:
	li a7 4             # a7 = 4 (print string)
	la a0 read_n        # a0 = &read_n
	ecall               # print a0

	li a7 5             # a7 = 5 (read int)
	ecall               # a0 = n
	mv s0 a0            # s0 = n

	li a7 4             # a7 = 4 (print string)
	la a0 str_res1      # a0 = &str_res1
	ecall               # print a0

	li a7 1             # a7 = 1 (print int)
	mv a0 s0            # a0 = n
	ecall               # print n

	li a7 4             # a7 = 4 (print string)
	la a0 str_res2      # a0 = &str_res2
	ecall               # print a0

	li a7 1             # a7 = 1 (print int)
	mv a0 s0            # a0 = n
	jal ra fatorial     # a0 = fatorial(n)
	ecall               # print fatorial(n)
	j fim               # exit

fatorial:             # void fatorial(int a0)
	addi sp sp -16      # prologue (stack management)
	sw s0 0(sp)         # prologue (stack management)
	sw s1 4(sp)         # prologue (stack management)
	sw s2 8(sp)         # prologue (stack management)
	sw ra 12(sp)        # saves ra in the stack

	mv s0 a0            # s0 = n
	li s1 1             # s1 (i) = 1
	li s2 1             # s2 (res) = 1

	loop_f:             # while (i <= n)
		blt s0 s1 end_f   # if (n < i) break;
		mv a0 s2          # a0 = n
		mv a1 s1          # a1 = i
		jal ra multiply_p # a0 = multiply(a0, a1)
		mv s2 a0          # s2 = multiply(a0, a1)
		addi s1 s1 1      # i++
		j loop_f

	end_f:
		mv a0 s2          # a0 = s2 (res)
		
		lw s0 0(sp)       # epilogue (stack management)
		lw s1 4(sp)       # epilogue (stack management)
		lw s2 8(sp)       # epilogue (stack management)
		lw ra 12(sp)      # retrieves ra from the stack
		addi sp sp 16     # epilogue (stack management)

		jr ra             # return res

multiply_p:           # int multiply(a0, a1)
                      # (only positive integers greater than 0, for this exercise purpose)
	li t0 1             # t0 = 1
	mv t1 a0            # t1 = a0
	loop_m:             # while (t0 < a1)
		bge t0 a1 end_m   # if (t0 >= a1) break
		add a0 a0 t1      # a0 += t1
		addi t0 t0 1      # t0++
		j loop_m          # goto loop_m
	end_m:
		jr ra             # return a0

fim:
	li a7 93            # a7 = 93 (exit code)
	xor a0 a0 a0        # a0 = 0 (exit status)
	ecall               # exits
