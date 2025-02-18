// main.c
#include <stdio.h>
#include "mylib.h"

int main(void) {
    int sum = add(5, 3);
    int product = multiply(5, 3);
    printf("Sum: %d\nProduct: %d\n", sum, product);
    return 0;
}

