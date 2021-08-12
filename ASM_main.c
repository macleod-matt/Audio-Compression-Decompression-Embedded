#include <stdio.h>

int main()
{
    int Val = 0x3543;
    int NumOfLeadingZeros = 0;
    int Val2 = 0X2403;
    int NumOfLeadingZeros2 = 0;
    int Val3 = 0X24;
    int NumOfLeadingZeros3 = 0;
    int Val4 = 0X304;
    int NumOfLeadingZeros4 = 0;


    asm volatile (
        "CLZ\t%0, %1" //Find Leading Zeros
        : "=r"(NumOfLeadingZeros)
        : "r"(Val));

    asm volatile (
        "CLZ\t%0, %1" //Find Leading Zeros
        : "=r"(NumOfLeadingZeros2)
        : "r"(Val2));

    asm volatile (
        "CLZ\t%0, %1" //Find Leading Zeros
        : "=r"(NumOfLeadingZeros3)
        : "r"(Val3));

    asm volatile (
        "CLZ\t%0, %1" //Find Leading Zeros
        : "=r"(NumOfLeadingZeros4)
        : "r"(Val4));

    printf("Val1 Leading Zeros: %d\n", NumOfLeadingZeros);
    printf("Val2 Leading Zeros: %d\n", NumOfLeadingZeros2);
    printf("Val3 Leading Zeros: %d\n", NumOfLeadingZeros3);
    printf("Val4 Leading Zeros: %d\n", NumOfLeadingZeros4);

    return 0;
}