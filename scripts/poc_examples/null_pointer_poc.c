// null_pointer_poc.c – Simple NULL pointer dereference PoC
#include <stdio.h>
#include <stdlib.h>

int main() {
    int *ptr = NULL;
    printf("Trying to dereference NULL pointer...\n");
    *ptr = 42; // This will crash
    return 0;
}
