# --------------------------------------------------------- #
# FUNDAMENTOS DE SISTEMAS COMPUTACIONAIS - FUNCOES - RISC-V #
#             Prof. Iacana Ianiski Weber - PUCRS            #
# --------------------------------------------------------- #
# int foo(int i) {
# 	if(i == 0) return 0;
#
# 	int a = i + foo(i-1);
# 	return a;
# }
#
# void main(){
# 	int j = foo(3);
# 	int k = foo(100);
# 	int m = j + k;
# }
# -----------------------------------------------------------
.globl main
# -----------------------------------------------------------
.data # Dados do programa
m: .word 0
# -----------------------------------------------------------
.text # Codigo
main:
	li a0 3          # int j = foo(3)
	jal ra foo       # call foo
	mv s0 a0         # mv rd rs1 sets rd = rs1

	li a0 100        # int k = foo(100)
	jal ra foo       # call foo
	mv s1 a0         # saves return value in s1

	add a0 s0 s1     # int m = j + k

	la t0 m          # t0 = &m
	sw a0 0(t0)      # mem[&m] = m
	j fim

foo:               # int foo(int i)
	addi sp sp -8    # prologue
	sw ra 0(sp)      # prologue: salva ra na pilha no inicio da funcao
	sw s0 4(sp)      # prologue: se modificarmos s0, precisamos restaura-lo; salvamos seu
									   # valor antigo na pilha e restauramos mais tarde
	mv s0 a0         # move i

	bne s0 x0 next   # if (i == 0) return 0
	li a0 0
	j epilogue

next:
	addi t0 s0 -1    # int j = i - 1; usando t0 para j e a0 para a entrada; da forma como foo
									   # funciona, precisamos mover dados de/para a0 para entrada/saida da funcao
	mv a0 t0
	jal ra foo       # j = foo(j)

	mv t0 a0
	add a0 s0 t0     # int a = i + j

epilogue:
	lw ra 0(sp)      # epilogue
	lw s0 4(sp)      # epilogue
	addi sp sp 8     # epilogue: restaura ra da pilha e restaura a pilha
	jr ra

fim:
	j fim
