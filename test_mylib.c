// test_mylib.c
#include <assert.h>
#include <stdio.h>
#include "mylib.h"

// Test function for add()
void test_add(void) {
    assert(add(2, 3) == 5);
    assert(add(-1, 1) == 0);
    assert(add(0, 0) == 0);
    printf("test_add passed\n");
}

// Test function for multiply()
void test_multiply(void) {
    assert(multiply(2, 3) == 6);
    assert(multiply(-2, 3) == -6);
    printf("test_multiply passed\n");
}

// Setup test suite
int main() {
   test_add();
   test_multiply();

   printf("All tests passed");
   return 0;
}

