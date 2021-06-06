
#ifndef MULAWAPI_H
#define MULAWAPI_H
#include <unistd.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "read_wav.h"
// macros


//Chage to 1 for Debugging mode and 0 otherwise
#define DEBUG 1
#define debug_print(fmt, ...)                    \
    do                                           \
    {                                            \
        if (DEBUG)                               \
            fprintf(stderr, fmt, ##__VA_ARGS__); \
    }   while (0)




// Functions 

int signum(int sample); 

int codeword_compression(unsigned int sample_magnitude, int sign); 

int codeword_decompression(int codeWord); 

int Test(int sample); 


#endif 

