# ---------------------------------------------- #
# FUNDAMENTOS DE SISTEMAS COMPUTACIONAIS - PUCRS #
#         ASSEMBLY DO RISC-V - LISTA II          #
# ---------------------------------------------- #
# Exercicio 1 ------------------------------------
# Considerando o vetor de dados declarado em `.data`,
# com seu valor inicial armazenado em `s0`, descreva
# sucintamente o que cada trecho de código assinalado faz:
# ------------------------------------------------
.data
v: .word 1 2 3 4 5 6 0
# ------------------------------------------------
.text
.globl main

main:
	la s0 v

	# a)
	lw t0 12(s0)
	# a) carrega, no registrador `t0`, o valor no índice 3 do vetor (12 / 4b = 3, t0 = v[3] = 4).

	# b)
	sw t0 16(s0)
	# b) armazena o valor de t0 no índice 4 do vetor, sobrescrevendo o valor anterior daquela posição.
	# (16 / 4b = 4, v[4] = 4).

	# c)
	slli t1 t0 2   # t1 = t0 * 2^2 = 16
	add t2 s0 t1   # t2 = &v + 16 = &v[4]
	lw t3 0(t2)    # t3 = v[4] = 4
	addi t3 t3 1   # t3++
	sw t3 0(t2)    # v[4] = 5
	# c) multiplica o valor de t0 por 4 e armazena em t1, depois soma este valor com o endereço do vetor em s0
	# e salva em t2; carrega o valor no endereço de t2 em t3, soma 1 e depois salva o valor na mesma posição.

	# d)
	lw t0 0(s0)    # t0 = v[0] = 1
	# xori t0 t0 0xfff # "0xfff": Unsigned value is too large to fit into a sign-extended immediate
	# This is what the pseudo instruction li is for. Same issues with any fixed length instruction set (arm, mips, etc).
  # In this case they specify a pseudo instruction `li` and then the assembler chooses, ideally, the optimal
  # instructions to complete that, for rv32 it should be no more than two instructions, for rv64 of course can be more,
  # but at the same time it may do a pc relative load from a nearby pool which is another option.
  # Immediate values have a fixed bit-length which is defined by the instruction format (see section 2.2 in the official
  # RISC-V spec for a nice diagram). In RV32I, I-type instructions like addi have a 12-bit immediate, meaning that they
  # can represent 4096 (2^12). You can always shift bits left and add another value to it to create larger values.
  # If you can't do something in one instruction, then use two or as many as needed.
	li t1 0xfff    # t1 = 0xfff
	xor t0 t0 t1   # t0 ^= 0xfff = 0xffe
	addi t0 t0 1   # t0++ = 0xfff
	# d) amazena, em t0, o valor da primeira posição do vetor (1), realiza uma operação de xor com o valor 0xfff
	# e depois soma 1.

	li a7 93       # a7 = 93 (exit code)
	xor a0 a0 a0   # a0 = 0 (exit status)
	ecall          # exits
