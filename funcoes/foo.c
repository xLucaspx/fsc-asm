#include <stdio.h>

int foo(int i) {
	if (i == 0) return 0;
	return i + foo(i - 1);
}

int main() {
	int j = foo(3);
	int k = foo(100);
	int m = j + k;

	printf("decimal:     { j: %d, k: %d, m: %d }\n", j, k, m);
	printf("hexadecimal: { j: %x, k: %x, m: %x }\n", j, k, m);
	return 0;
}
