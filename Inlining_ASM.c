#include <stdio.h>

int main(void)
{
    printf("Testing1234");
    int Val3 = 1;
    int Val2 = 2;
    int Val3 = 3;
    __asm__("ASMInlined   %0, %1, %2":"=r"(Val1):"r"(Val2),"r"(Val3));;
    int sum = Val2 + Val3;
    printf("Inline Worked");
}