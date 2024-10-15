# ---------------------------------------------- #
# FUNDAMENTOS DE SISTEMAS COMPUTACIONAIS - PUCRS #
#          ASSEMBLY DO RISC-V - LISTA I          #
# ---------------------------------------------- #
# Exercicio 5 ------------------------------------
# Traduizr o seguinte código para assembly RISC-V:
#
# int array[3] = { 1, 2, 3 };
# int sum = array[0] + array[1] + array[2];
# ------------------------------------------------
.data # Dados do programa
array: .word 1, 2, 3
sum:   .word 0
# ------------------------------------------------
.text # Codigo
.globl main
main:
	la t0 array      # t0 = &array
	li t1 0          # t1 = 0 (i)
	li t2 3          # t2 = 3 (array.size)
	li s0 0          # s0 = 0 (sum)

loop:
	bge t1 t2 endl   # if (i >= size) break
	slli t3 t1 2     # t3 = t1 * 4 (deslocamento para acessar posição do array)
	add t3 t0 t3     # t3 = &array[i]
	lw t3 0(t3)      # t3 = array[i]
	add s0 s0 t3     # sum += array[i]
	addi t1 t1 1     # i++
	j loop

endl:
	la t0 sum        # t0 = &sum
	sw s0 0(t0)      # mem[&sum] = sum

	li a7 93         # a7 = 93 (exit code)
	xor a0 a0 a0     # a0 = 0 (exit status)
	ecall            # exits
