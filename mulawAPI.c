#include "read_wav.h"
#include "mulawAPI.h"
#include <stdint.h> 
#include <stdbool.h> 
#include <stdio.h>
#include <string.h>
#include <time.h>
//Convers decimal to bin

// function to convert decimal to binary
void decToBinary(int n)
{
    // array to store binary number
    int binaryNum[32];
 
    // counter for binary array
    int i = 0;
    while (n > 0) {
 
        // storing remainder in binary array
        binaryNum[i] = n % 2;
        n = n / 2;
        i++;
    }
    int j;  
    // printing binary array in reverse order
    for (j = i - 1; j >= 0; j--)
        printf("%d", binaryNum[j]);
}

void codeword_compression(void)
{
    //Simulate the use of an Instantiated Machine-level Custom Instruction
    return; //Error
}

void codeword_decompression(void)
{
    return;
} 



int Test(int sample)
{
    printf("\nTurn debugging to 1 in mulawAPI.h for debugging mode\n\n");

    codeword_compression(void);
    codeword_decompression(void);

    return 0;
}
