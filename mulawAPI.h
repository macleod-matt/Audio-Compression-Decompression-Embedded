
#ifndef MULAWAPI_H
#define MULAWAPI_H

#include <stdio.h>
#include <string.h>
#include "read_wav.h"


// macros

#define DEBUG (0)

#if DEBUG == 1
    #define debug_print printf
#else 
    #define debug_print
#endif 


//#define magnitude(sample) ((sample < 0) ? -sample : sample)           //This is for +/- inputs
#define magnitude(sample) ((sample & 0x2000) ? sample & 0x1FFF : sample)      //This is for 0/1 inputs that work with the program

#define signum(num) (num & 0x2000) 



// Functions 
 

void codeword_compression(void);

void codeword_decompression(void);

int Test(int sample); 

#endif 

